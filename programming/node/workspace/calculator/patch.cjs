// This patch file modifies path-to-regexp to prevent "Missing parameter name" errors
// by sanitizing URL patterns before they are processed

// Monkey patch path-to-regexp
try {
  // Get the path-to-regexp module
  const pathToRegexp = require('path-to-regexp');
  
  // Store the original parse function
  const originalParse = pathToRegexp.parse;
  
  // Replace with our patched version
  pathToRegexp.parse = function(str) {
    // Check for URLs in route patterns
    if (typeof str === 'string' && (str.includes('http://') || str.includes('https://'))) {
      console.warn(`[PATCH] Detected URL in route pattern: ${str}, converting to safe path`);
      str = '/';
    }
    return originalParse(str);
  };
  
  console.log('[PATCH] Successfully patched path-to-regexp');
} catch (err) {
  console.error('[PATCH] Failed to patch path-to-regexp:', err);
}