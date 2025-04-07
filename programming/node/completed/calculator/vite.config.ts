import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  // Base public path when served in development
  base: './',
  
  // Configure the server
  server: {
    port: 3000,
    open: true, // Auto-open browser
    watch: {
      usePolling: true,
    }
  },
  
  // Configure build output
  build: {
    outDir: 'dist',
    sourcemap: true,
    emptyOutDir: true,
  },
  
  // Configure input files and directory
  root: 'src',
  publicDir: 'public',
  
  // Configure module resolution
  resolve: {
    alias: {
      '@': resolve(__dirname, './src')
    }
  }
});