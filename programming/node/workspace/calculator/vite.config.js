// vite.config.js
export default {
  root: 'src',
  base: './',
  server: {
    port: 3000,
    open: './calculator.html',
    hmr: {
      overlay: true
    }
  },
  build: {
    outDir: '../dist',
    emptyOutDir: true
  }
}