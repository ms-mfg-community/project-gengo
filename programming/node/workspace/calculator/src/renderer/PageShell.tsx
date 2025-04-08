import React from 'react';
import type { PageContext } from './types';
import './PageShell.css';

interface PageShellProps {
  children: React.ReactNode;
  pageContext: PageContext;
}

export function PageShell({ children, pageContext }: PageShellProps) {
  return (
    <React.StrictMode>
      <Layout>
        {children}
      </Layout>
    </React.StrictMode>
  );
}

function Layout({ children }: { children: React.ReactNode }) {
  return (
    <div className="layout">
      <main>{children}</main>
    </div>
  );
}