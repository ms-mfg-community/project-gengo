# Calculator App with Vite, React, TypeScript and SSR

A simple calculator application built using Vite, React, TypeScript, and Server-Side Rendering (SSR) with Hot Module Replacement (HMR).

## Features

- Server-Side Rendering (SSR) for improved performance and SEO

- Hot Module Replacement (HMR) for a fast development experience

- TypeScript support for type safety

- SWC compiler for faster builds

- Basic calculator functionality (addition, subtraction, multiplication, division)

## Getting Started

### Prerequisites

- Node.js (v16 or higher)

- npm (v7 or higher)

### Installation

1. Clone the repository
1. Install dependencies:

```

bash
npm install

```

text
text

### Development

To start the development server with HMR:

```

bash
npm run dev

```

text
text

This will start the SSR server with hot module replacement at `http://localhost:3000`.

### Building for Production

To build the application for production:

```

bash
npm run build

```

text
text

This will create optimized client and server bundles in the `dist` directory.

### Running in Production

To run the application in production mode:

```

bash
npm run start

```

text
text

or

```

bash
npm run preview

```

text
text

This will serve the application using the built files at `http://localhost:3000`.

## Project Structure

- `server/` - Server-side code for SSR implementation

- `src/`
  - `pages/` - Page components and routes
  - `renderer/` - Client and server renderers for SSR
  - `components/` - Reusable React components

- `public/` - Static assets

## Technologies

- [Vite](https://vitejs.dev/) - Frontend tooling

- [React](https://reactjs.org/) - UI library

- [TypeScript](https://www.typescriptlang.org/) - Type safety

- [SWC](https://swc.rs/) - Fast compiler

- [vite-plugin-ssr](https://vite-plugin-ssr.com/) - Server-side rendering implementation

- [Express](https://expressjs.com/) - Web server framework
