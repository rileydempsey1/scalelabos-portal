import Anthropic from '@anthropic-ai/sdk'
import { createServerSupabaseClient } from '@/lib/supabase-server'
import { NextResponse } from 'next/server'

const anthropic = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY })

const DAILY_LIMIT = 30

export async function POST(request) {
  try {
    const supabase = await createServerSupabaseClient()
    const { data: { user }, error: authError } = await supabase.auth.getUser()
    if (authError || !user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Rate limiting: 30 messages per day
    const today = new Date().toISOString().split('T')[0]
    const { data: usage } = await supabase
      .from('coach_usage')
      .select('message_count')
      .eq('user_id', user.id)
      .eq('date', today)
      .single()

    const currentCount = usage?.message_count || 0
    if (currentCount >= DAILY_LIMIT) {
      return NextResponse.json({
        error: `You have reached the ${DAILY_LIMIT} message daily limit. Come back tomorrow.`
      }, { status: 429 })
    }

    const { message, courseId, lessonId, conversationHistory } = await request.json()
    if (!message) return NextResponse.json({ error: 'Message required' }, { status: 400 })

    // Build context bundle: user profile + all lesson state for this course + uploaded file data
    const [profileResult, lessonStatesResult, uploadsResult] = await Promise.all([
      supabase.from('profiles').select('company_name, annual_revenue').eq('id', user.id).single(),
      supabase.from('lesson_state').select('lesson_id, data, completed').eq('user_id', user.id).eq('course_id', courseId),
      supabase.from('uploads').select('original_filename, parsed_data, lesson_id').eq('user_id', user.id).eq('course_id', courseId),
    ])

    const profile = profileResult.data
    const lessonStates = lessonStatesResult.data || []
    const uploads = uploadsResult.data || []

    // Build context string
    const contextParts = []

    if (profile) {
      contextParts.push(`USER PROFILE:
Company: ${profile.company_name || 'Not provided'}
Revenue Range: ${profile.annual_revenue || 'Not provided'}`)
    }

    if (lessonStates.length > 0) {
      const inputSummary = lessonStates
        .filter(ls => ls.data && ls.data.inputs && Object.keys(ls.data.inputs).length > 0)
        .map(ls => `Lesson ${ls.lesson_id} inputs: ${JSON.stringify(ls.data.inputs)}`)
        .join('\n')
      if (inputSummary) {
        contextParts.push(`USER INPUTS FROM THIS COURSE:\n${inputSummary}`)
      }
    }

    if (uploads.length > 0) {
      const uploadSummary = uploads
        .filter(u => u.parsed_data && Object.keys(u.parsed_data).length > 0)
        .map(u => `File: ${u.original_filename}\nParsed data: ${JSON.stringify(u.parsed_data).slice(0, 2000)}`)
        .join('\n\n')
      if (uploadSummary) {
        contextParts.push(`UPLOADED FILE DATA:\n${uploadSummary}`)
      }
    }

    const contextBundle = contextParts.join('\n\n---\n\n')

    const systemPrompt = `You are a senior operating partner advising a contractor running a $1M-$10M business. You are inside their Scale Lab OS portal, helping them work through a business improvement course.

Be direct, blunt, and useful. Use their actual numbers from the context when they are available. Never invent data they did not give you. Give specific, actionable advice — not general principles.

No em dashes. No coaching jargon. No filler phrases like "great question" or "absolutely." Just real advice from someone who has run real businesses.

${contextBundle ? `CONTEXT ABOUT THIS USER:\n${contextBundle}` : 'No user data entered yet for this course.'}`

    // Build messages array for Claude
    const messages = [
      ...(conversationHistory || []).slice(-10), // Last 10 messages for context window
      { role: 'user', content: message }
    ]

    const response = await anthropic.messages.create({
      model: 'claude-sonnet-4-5',
      max_tokens: 1024,
      system: systemPrompt,
      messages,
    })

    const assistantMessage = response.content[0].text

    // Save conversation to DB
    await supabase.from('coach_conversations').insert([
      { user_id: user.id, course_id: courseId, lesson_id: lessonId, role: 'user', content: message },
      { user_id: user.id, course_id: courseId, lesson_id: lessonId, role: 'assistant', content: assistantMessage },
    ])

    // Increment usage counter
    await supabase.from('coach_usage').upsert({
      user_id: user.id,
      date: today,
      message_count: currentCount + 1,
    }, { onConflict: 'user_id,date' })

    return NextResponse.json({
      message: assistantMessage,
      messagesRemaining: DAILY_LIMIT - currentCount - 1,
    })

  } catch (err) {
    console.error('Coach API error:', err)
    return NextResponse.json({ error: 'Something went wrong. Try again.' }, { status: 500 })
  }
}
