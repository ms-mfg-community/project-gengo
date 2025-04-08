import React from 'react';
import ReactDOM from 'react-dom/client';
import { hydrateRoot } from 'react-dom/client';
import { PageShell } from './PageShell';
import type { PageContextClient } from './types';

export async function render(pageContext: PageContextClient) {
  const { Page, pageProps } = pageContext;
  
  if (!Page) throw new Error('Client-side render() hook expects pageContext.Page to be defined');
  
  const root = document.getElementById('root');
  if (!root) throw new Error('DOM element #root not found');

  const page = (
    <PageShell pageContext={pageContext}>
      <Page {...pageProps} />
    </PageShell>
  );

  if (pageContext.isHydration) {
    // Client-side hydration (first render)
    hydrateRoot(root, page);
  } else {
    // Client-side navigation (subsequent renders)
    const rootElement = ReactDOM.createRoot(root);
    rootElement.render(page);
  }
}