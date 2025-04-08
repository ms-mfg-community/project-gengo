import fs from 'node:fs/promises'
import express from 'express'
import dotenv from 'dotenv'
import sql from 'mssql'
import readlineSync from 'readline-sync'

// Load environment variables
dotenv.config()

// Constants
const isProduction = process.env.NODE_ENV === 'production'
const port = process.env.PORT || 5173
const base = process.env.BASE || '/'

// Cached production assets
const templateHtml = isProduction
  ? await fs.readFile('./dist/client/index.html', 'utf-8')
  : ''

// Create http server
const app = express()

// Add JSON parsing middleware
app.use(express.json())

// Add Vite or respective production middlewares
/** @type {import('vite').ViteDevServer | undefined} */
let vite
if (!isProduction) {
  const { createServer } = await import('vite')
  vite = await createServer({
    server: { middlewareMode: true },
    appType: 'custom',
    base,
  })
  app.use(vite.middlewares)
} else {
  const compression = (await import('compression')).default
  const sirv = (await import('sirv')).default
  app.use(compression())
  app.use(base, sirv('./dist/client', { extensions: [] }))
}

// API endpoint to fetch calculator test data
app.get('/api/calculator-data', async (req, res) => {
  try {
    // Use environment variable for password without prompting
    const password = process.env.DB_PASSWORD || 'dev_password';
    
    // Configure SQL connection
    const config = {
      user: process.env.DB_USER,
      password: password,
      server: process.env.DB_SERVER,
      database: process.env.DB_DATABASE,
      options: {
        encrypt: true,
        trustServerCertificate: false
      }
    };
    
    // Connect to database
    await sql.connect(config);
    
    // Query the calculator table
    const result = await sql.query(`SELECT * FROM [dbo].[${process.env.DB_TABLE}]`);
    
    // Return the data as JSON
    res.json(result.recordset);
  } catch (err) {
    console.error('Database query error:', err);
    res.status(500).json({ 
      error: 'Error fetching calculator data', 
      details: isProduction ? null : err.message
    });
  } finally {
    // Close SQL connection
    try {
      await sql.close();
    } catch (err) {
      console.error('Error closing SQL connection:', err);
    }
  }
});

// Serve HTML
app.use('*all', async (req, res) => {
  try {
    const url = req.originalUrl.replace(base, '')

    /** @type {string} */
    let template
    /** @type {import('./src/entry-server.ts').render} */
    let render
    if (!isProduction) {
      // Always read fresh template in development
      template = await fs.readFile('./index.html', 'utf-8')
      template = await vite.transformIndexHtml(url, template)
      render = (await vite.ssrLoadModule('/src/entry-server.tsx')).render
    } else {
      template = templateHtml
      render = (await import('./dist/server/entry-server.js')).render
    }

    const rendered = await render(url)

    const html = template
      .replace(`<!--app-head-->`, rendered.head ?? '')
      .replace(`<!--app-html-->`, rendered.html ?? '')

    res.status(200).set({ 'Content-Type': 'text/html' }).send(html)
  } catch (e) {
    vite?.ssrFixStacktrace(e)
    console.log(e.stack)
    res.status(500).end(e.stack)
  }
})

// Start http server
app.listen(port, () => {
  console.log(`Server started at http://localhost:${port}`)
})
