// This is a fixed version of the server file that avoids using problematic URL patterns
import { createServer } from './server/index-fixed.js';

// Execute the server
createServer();