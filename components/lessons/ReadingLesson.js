'use client'
import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'

export default function ReadingLesson({ lesson, onComplete }) {
  return (
    <div className="space-y-6">
      <div className="prose prose-sm max-w-none">
        <div className="bg-white border border-brand-border rounded-xl p-8 leading-relaxed text-brand-text">
          <ReactMarkdown
            remarkPlugins={[remarkGfm]}
            components={{
              h2: ({children}) => <h2 className="text-xl font-bold text-navy mt-6 mb-3 first:mt-0">{children}</h2>,
              h3: ({children}) => <h3 className="text-base font-bold text-navy mt-5 mb-2">{children}</h3>,
              p: ({children}) => <p className="text-sm leading-relaxed text-gray-700 mb-4">{children}</p>,
              ul: ({children}) => <ul className="space-y-1.5 mb-4 pl-4">{children}</ul>,
              li: ({children}) => <li className="text-sm text-gray-700 relative pl-4 before:content-[''] before:absolute before:left-0 before:top-2 before:w-1.5 before:h-1.5 before:bg-steel before:rounded-full">{children}</li>,
              strong: ({children}) => <strong className="font-semibold text-navy">{children}</strong>,
              table: ({children}) => <div className="overflow-x-auto mb-4"><table className="w-full text-sm border-collapse">{children}</table></div>,
              th: ({children}) => <th className="bg-navy text-white text-left px-4 py-2.5 text-xs font-semibold">{children}</th>,
              td: ({children}) => <td className="border-b border-brand-border px-4 py-2.5 text-sm">{children}</td>,
              blockquote: ({children}) => <blockquote className="border-l-4 border-steel bg-blue-50 px-5 py-4 my-4 rounded-r-lg">{children}</blockquote>,
            }}
          >
            {lesson.content.body || ''}
          </ReactMarkdown>
        </div>
      </div>
      {lesson.content.callout && (
        <div className="bg-navy rounded-xl p-6 text-white">
          <div className="text-xs font-bold text-blue-300 uppercase tracking-widest mb-2">Key Takeaway</div>
          <p className="text-sm leading-relaxed">{lesson.content.callout}</p>
        </div>
      )}
      <div className="flex justify-end">
        <button onClick={onComplete} className="btn-primary">
          Mark as read — Continue
        </button>
      </div>
    </div>
  )
}
