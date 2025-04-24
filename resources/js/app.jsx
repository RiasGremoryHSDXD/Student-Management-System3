// import React from 'react';
// import { createRoot } from 'react-dom/client';
// import Customer from './Pages/Customers'
// import '../css/tailwind.css'

// function App() {
//   return(
//     <Customer customers={[]}/>
//   )
// }

// createRoot(document.getElementById('app') as HTMLElement).render(
//   <React.StrictMode>
//     <App />
//   </React.StrictMode>
// );

// import { createInertiaApp } from '@inertiajs/react'
// import { createRoot } from 'react-dom/client'

// createInertiaApp({
//   resolve: name => {
//     const pages = import.meta.glob('./Pages/**/*.jsx,tsx', { eager: true })
//     return pages[`./Pages/${name}.tsx`]
//   },
//   setup({ el, App, props }) {
//     createRoot(el).render(<App {...props} />)
//   },
// })

import { createInertiaApp } from '@inertiajs/react'
import { createRoot } from 'react-dom/client'

createInertiaApp({
  resolve: name => {
    const pages = import.meta.glob('./Pages/**/*.tsx', { eager: true })
    return pages[`./Pages/${name}.tsx`]
  },
  setup({ el, App, props }) {
    createRoot(el).render(<App {...props} />)
  },
})
