/// <reference types="vite/client" />
/// <reference types="vite-plugin-ssr/client" />

declare module '*.css' {
  const classes: { readonly [key: string]: string };
  export default classes;
}
