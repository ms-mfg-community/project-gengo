import { defineConfig } from 'vite-plugin-ssr/config';

export default defineConfig({
  // Base configuration for all pages
  rootLayout: null, // Using our own PageShell component
  meta: {
    // Default metadata for all pages
    title: 'Calculator App',
    description: 'A calculator app built with Vite, React, TypeScript, and SSR'
  },
  clientRouting: true, // Enable client-side routing for SPA-like navigation
  hydrationCanBeAborted: true // Allow hydration to be aborted for better performance
});