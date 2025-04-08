// A custom server implementation that avoids Express's path-to-regexp issues
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer as createViteServer } from 'vite';
import http from 'http';
import compression from 'compression';
import sirv from 'sirv';

// Constants
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const isProduction = process.env.NODE_ENV === 'production';
const PORT = process.env.PORT || 3000;

async function createServer() {
  // Create Vite server in middleware mode
  const vite = await createViteServer({
    server: { middlewareMode: true },
    appType: 'custom'
  });

  // Create middleware pipeline
  const middlewares = [];
  
  // Add compression middleware
  middlewares.push(compression());
  
  // Add Vite middleware
  middlewares.push(vite.middlewares);
  
  // Add static file serving in production
  if (isProduction) {
    const serve = sirv('dist/client', { gzip: true });
    middlewares.push((req, res, next) => {
      serve(req, res, next);
    });
  }

  // Create HTTP server
  const server = http.createServer(async (req, res) => {
    const url = req.url || '/';
    
    // Skip URLs with "://" to avoid path-to-regexp errors
    if (url.includes('://')) {
      console.warn(`Skipping problematic URL: ${url}`);
      res.statusCode = 400;
      res.end('Invalid URL format');
      return;
    }
    
    // Run request through middleware pipeline
    try {
      let currentMiddlewareIndex = 0;
      
      const runNextMiddleware = (err) => {
        if (err) {
          console.error('Middleware error:', err);
          res.statusCode = 500;
          res.end('Internal Server Error');
          return;
        }
        
        const currentMiddleware = middlewares[currentMiddlewareIndex];
        currentMiddlewareIndex++;
        
        if (currentMiddleware) {
          try {
            currentMiddleware(req, res, runNextMiddleware);
          } catch (error) {
            runNextMiddleware(error);
          }
        } else {
          // If we've gone through all middleware, handle SSR
          handleSSR(req, res, url, vite).catch(error => {
            vite.ssrFixStacktrace(error);
            console.error('SSR error:', error);
            res.statusCode = 500;
            res.end('Server Error');
          });
        }
      };
      
      runNextMiddleware();
    } catch (error) {
      console.error('Request handling error:', error);
      res.statusCode = 500;
      res.end('Server Error');
    }
  });
  
  // Helper function to handle Server-Side Rendering
  async function handleSSR(req, res, url, vite) {
    // Load server entry point
    const { render } = await vite.ssrLoadModule('/src/entry-server.tsx');
    
    // Render the app
    const appHtml = await render(url);
    
    // Read the index.html template
    const template = fs.readFileSync(
      isProduction 
        ? path.resolve(__dirname, './dist/client/index.html')
        : path.resolve(__dirname, './index.html'),
      'utf-8'
    );
    
    // Apply Vite HTML transforms
    const transformedTemplate = await vite.transformIndexHtml(url, template);
    
    // Inject the app HTML into the template
    const html = transformedTemplate.replace('<!--ssr-outlet-->', appHtml);
    
    // Send the response
    res.setHeader('Content-Type', 'text/html');
    res.end(html);
  }

  // Start the server
  server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
  });

  return server;
}

// Start the server
createServer().catch(err => {
  console.error('Failed to start server:', err);
  process.exit(1);
});