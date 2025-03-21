/*
alter table demo_catalog
	add column demo_embedding vector(1536) --Creates a vector column with 1536 dimensions
	generated always as
	(azure_openai.create_embeddings('text-embedding-ada-002' -- Calls Azure OpenAI deployment
	 ,points || category || sub_category || language || role || person || ide_type || prompt_type 
	 || shot_type || is_test || epoch || confidence_percent || scenario || github_org || reference
	 || data_source || notes)::vector) STORED; -- stores the vector
*/
-- Add hnsw indexes as needed. 
-- vector_ip_ops means using inner product for indexing/search.
-- HNSW (Hierarchical Navigable Small Worlds) indexing is fast and efficient for vector searches.
-- create index on demo_catalog using hnsw (demo_embedding vector_cosine_ops);




	 