// This patch file modifies path-to-regexp to prevent "Missing parameter name" errors
// by sanitizing URL patterns before they are processed

// Attempt to patch the path-to-regexp library
try {
  // Find the path-to-regexp module
  const pathToRegexpPath = require.resolve('path-to-regexp');
  
  // Get the original module
  const originalModule = require(pathToRegexpPath);
  
  // Keep original functions
  const originalParse = originalModule.parse;
  
  // Patch the parse function to handle invalid patterns
  originalModule.parse = function patchedParse(str) {
    // Clean up URLs with http:// or https:// to prevent path-to-regexp errors
    if (typeof str === 'string' && (str.includes('http://') || str.includes('https://'))) {
      console.warn(`Detected URL in route pattern: ${str}, converting to safe path`);
      str = '/';
    }
    
    // Call the original function
    return originalParse.call(this, str);
  };
  
  console.log('[patch] Successfully patched path-to-regexp');
} catch (err) {
  console.error('[patch] Failed to patch path-to-regexp:', err.message);
}