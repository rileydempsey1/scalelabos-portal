import { NextResponse } from 'next/server'
import * as XLSX from 'xlsx'

export async function POST(request) {
  try {
    const formData = await request.formData()
    const file = formData.get('file')
    if (!file) return NextResponse.json({ error: 'No file' }, { status: 400 })

    const filename = file.name.toLowerCase()
    const buffer = Buffer.from(await file.arrayBuffer())

    let parsed = {}

    if (filename.endsWith('.xlsx') || filename.endsWith('.xls')) {
      const workbook = XLSX.read(buffer, { type: 'buffer' })
      const sheets = {}
      workbook.SheetNames.forEach(name => {
        const sheet = workbook.Sheets[name]
        const rows = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: '' })
        // Only keep first 100 rows and 20 columns to avoid huge payloads
        sheets[name] = rows.slice(0, 100).map(row => row.slice(0, 20))
      })
      parsed = { type: 'excel', sheets, sheet_names: workbook.SheetNames }
    } else if (filename.endsWith('.csv')) {
      const text = buffer.toString('utf-8')
      const lines = text.split('\n').slice(0, 100)
      const rows = lines.map(line => line.split(',').map(cell => cell.trim().replace(/^"|"$/g, '')))
      parsed = { type: 'csv', rows, row_count: lines.length }
    }

    return NextResponse.json({ parsed, success: true })
  } catch (err) {
    console.error('Upload parse error:', err)
    return NextResponse.json({ error: err.message }, { status: 500 })
  }
}
