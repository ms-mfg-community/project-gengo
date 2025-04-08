import React from 'react';
import { renderToString } from 'react-dom/server';
import { escapeInject, dangerouslySkipEscape } from 'vite-plugin-ssr/server';
import { PageShell } from './PageShell';
import type { PageContextServer } from './types';

export async function render(pageContext: PageContextServer) {
  const { Page, pageProps } = pageContext;
  
  if (!Page) throw new Error('Server-side render() hook expects pageContext.Page to be defined');
  
  const pageHtml = renderToString(
    <PageShell pageContext={pageContext}>
      <Page {...pageProps} />
    </PageShell>
  );

  const { documentProps } = pageContext;
  const title = (documentProps && documentProps.title) || 'Calculator App';
  const description = (documentProps && documentProps.description) || 'Vite SSR React TypeScript Calculator App';

  const documentHtml = escapeInject`<!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="${description}" />
        <title>${title}</title>
      </head>
      <body>
        <div id="root">${dangerouslySkipEscape(pageHtml)}</div>
      </body>
    </html>`;

  return {
    documentHtml,
    pageContext: {
      // We can add custom pageContext values here which will be available in the client
    }
  };
}