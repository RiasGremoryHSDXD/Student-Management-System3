import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    laravel({
      // include both your CSS and your TSX entry
      input: [
        'resources/css/app.css',
        'resources/js/app.tsx',
      ],
      refresh: true,
    }),
    react(),
    tailwindcss(),
  ],
});
