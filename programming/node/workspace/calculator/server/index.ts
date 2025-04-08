import express from 'express';
import compression from 'compression';
import { renderPage } from 'vite-plugin-ssr/server';
import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import sirv from 'sirv';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const isProduction = process.env.NODE_ENV === 'production';
const root = path.resolve(__dirname, '..');

startServer();

async function startServer() {
  const app = express();
  
  // Compression middleware for better performance
  app.use(compression());

  // Serve static assets
  if (isProduction) {
    app.use(sirv(`${root}/dist/client`, { dev: false }));
  } else {
    // During development, Vite runs its own server for assets
    const { createServer } = await import('vite');
    const viteDevServer = await createServer({
      root,
      server: { middlewareMode: true }
    });
    app.use(viteDevServer.middlewares);
  }

  // SSR middleware
  app.get('*', async (req, res, next) => {
    try {
      const pageContextInit = {
        urlOriginal: req.originalUrl
      };
      const pageContext = await renderPage(pageContextInit);
      const { httpResponse } = pageContext;
      
      if (!httpResponse) return next();
      
      const { body, statusCode, contentType, earlyHints } = httpResponse;
      
      if (res.writeEarlyHints && earlyHints) {
        res.writeEarlyHints({ link: earlyHints.map((e) => e.earlyHintLink) });
      }
      
      res.status(statusCode).type(contentType).send(body);
    } catch (error) {
      console.error(error);
      return next(error);
    }
  });

  const port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
  });
}
