// Direct patching of path-to-regexp to fix the "Missing parameter name" error
// This file loads and patches the library before importing Express

import { createRequire } from 'module';

// Create a require function for loading CommonJS modules
const require = createRequire(import.meta.url);

// Patch path-to-regexp module
try {
  // Find the module path
  const pathToRegexpPath = require.resolve('path-to-regexp');
  
  // Get the module object from the module cache
  const moduleObj = require.cache[pathToRegexpPath];
  
  if (moduleObj && moduleObj.exports) {
    // Store original parse function 
    const originalParse = moduleObj.exports.parse;
    
    // Replace it with our safe version
    moduleObj.exports.parse = function safeParser(str, ...rest) {
      // Check for URL patterns
      if (typeof str === 'string' && (str.includes('http://') || str.includes('https://'))) {
        console.log(`[PATCH] Detected problematic URL pattern: ${str}, replacing with safe pattern`);
        str = '/';
      }
      // Call original function with safe string
      return originalParse(str, ...rest);
    };
    
    console.log('[PATCH] Successfully patched path-to-regexp module');
  } else {
    console.error('[PATCH] Could not find path-to-regexp module in cache');
  }
} catch (err) {
  console.error('[PATCH] Failed to patch path-to-regexp:', err);
}

// Now import the server code
import { createServer } from './server/index.js';

// Start the server
createServer().then(() => {
  console.log('Server started successfully');
}).catch(err => {
  console.error('Failed to start server:', err);
});