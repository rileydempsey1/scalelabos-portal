import './globals.css'
import { ReactNode } from 'react'

export const metadata = {
  title: 'Scale Lab OS',
  description: 'Business operating system for contractors doing $1M–$10M',
}

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
