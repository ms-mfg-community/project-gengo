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

// Patch Express route handler to handle problematic URLs
// This needs to be done before any routes are defined
const originalExpressGet = express.Router.prototype.get;
express.Router.prototype.get = function(path, ...handlers) {
  // Ensure path is always properly formatted for path-to-regexp
  if (typeof path === 'string' && path.includes('://')) {
    console.warn('Detected URL in route pattern, converting to safe path');
    path = '*'; // Use a safe wildcard pattern instead
  }
  return originalExpressGet.call(this, path, ...handlers);
};

export async function createServer() {
  const app = express()

  // Create Vite server in middleware mode and configure the app type as
  // 'custom', disabling Vite's own HTML serving logic so the parent server
  // can take control
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

  // Route for all page requests - this will be handled by our SSR logic
  app.get('*', async (req, res, next) => {
    const url = req.originalUrl
    
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

  app.listen(PORT, () => {
     console.log(`Server running at http://localhost:${PORT}`)
  })

  return app
}

// Only execute the server if this file is run directly
if (import.meta.url === `file://${process.argv[1]}`) {
  createServer()
}
