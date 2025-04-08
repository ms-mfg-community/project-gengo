import fs from 'fs'
import path from 'path'
import { fileURLToPath } from 'url'
import express from 'express'
import compression from 'compression'
import sirv from 'sirv'
import { createServer as createViteServer } from 'vite'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const isProduction = process.env.NODE_ENV === 'production'
const PORT = process.env.PORT || 3000

// Define a custom error handler to catch path-to-regexp errors
const errorHandler = (err, req, res, next) => {
  if (err.message && err.message.includes('Missing parameter name')) {
    console.error('Path-to-regexp error caught:', err.message);
    return res.status(400).send('Invalid URL format');
  }
  next(err);
};

export async function createServer() {
  const app = express()

  // Add custom error handler early
  app.use(errorHandler);
  
  try {
    // Create Vite server in middleware mode
    const vite = await createViteServer({
      server: { middlewareMode: true },
      appType: 'custom'
    })

    // Use Vite's connect instance as middleware
    app.use(vite.middlewares)
    
    // Compression middleware
    app.use(compression())

    if (isProduction) {
      // Serve static assets from 'dist/client'
      app.use(sirv('dist/client', { gzip: true }))
    }

    // Safe route handler for paths that might contain URLs
    app.get('*', async (req, res, next) => {
      const url = req.originalUrl
      
      // Skip invalid URL patterns that contain "://" (like https://)
      if (url.includes('://')) {
        console.warn(`Skipping problematic URL: ${url}`);
        return res.status(400).send('Invalid URL format');
      }
      
      try {
        // Load the server entry point
        const { render } = await vite.ssrLoadModule('/src/entry-server.tsx')
        
        // Render the app
        const appHtml = await render(url)
        
        // Read the index.html
        let template = fs.readFileSync(
          isProduction 
            ? path.resolve(__dirname, '../dist/client/index.html')
            : path.resolve(__dirname, '../index.html'),
          'utf-8'
        )

        // Apply Vite HTML transforms
        template = await vite.transformIndexHtml(url, template)
        
        // Inject the app-rendered HTML into the template
        const html = template.replace('<!--ssr-outlet-->', appHtml)
        
        // Send the rendered HTML
        res.status(200).set({ 'Content-Type': 'text/html' }).end(html)
      } catch (e) {
        // If an error occurred, let Vite fix the stack trace for better debugging
        vite.ssrFixStacktrace(e)
        next(e)
      }
    })
  } catch (initError) {
    console.error("Server initialization error:", initError);
    app.get('*', (req, res) => {
      res.status(500).send('Server initialization error');
    });
  }

  app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`)
  })

  return app
}

// Only execute the server if this file is run directly
if (import.meta.url === `file://${process.argv[1]}`) {
  createServer()
}