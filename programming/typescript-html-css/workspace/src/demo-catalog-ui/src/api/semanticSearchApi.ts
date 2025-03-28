/**
 * API service for semantic search functionality
 */

interface SearchResult {
  id: number;
  scenario: string;
  category: string;
  sub_category: string;
  language: string;
  role: string;
  similarity: number;
}

/**
 * Performs a semantic search using the provided query
 * @param query The search query text
 * @param limit Maximum number of results to return (default: 5)
 * @returns Promise containing search results
 */
export const performSemanticSearch = async (
  query: string, 
  limit: number = 5
): Promise<SearchResult[]> => {
  try {
    const response = await fetch('/api/semantic-search', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ query, limit }),
    });

    if (!response.ok) {
      throw new Error(`Error: ${response.status} ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error('Failed to perform semantic search:', error);
    throw error;
  }
};
