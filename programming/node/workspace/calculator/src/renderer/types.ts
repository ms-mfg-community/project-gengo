export type PageProps = Record<string, unknown>;

export interface PageContext {
  Page: (pageProps: PageProps) => React.ReactElement;
  pageProps: PageProps;
  urlPathname: string;
  documentProps?: {
    title?: string;
    description?: string;
  };
}

export interface PageContextServer extends PageContext {
  // Server-specific context properties
  isHydration?: false;
}

export interface PageContextClient extends PageContext {
  // Client-specific context properties
  isHydration: boolean;
}