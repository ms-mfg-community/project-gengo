from openai import AzureOpenAI
import psycopg2
import json
import getpass
import os
import logging
from tqdm import tqdm
from dotenv import load_dotenv

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Prompt for the OpenAI API key
OPENAI_API_KEY = getpass.getpass(prompt="Enter OpenAI API key: ")

# Initialize the Azure OpenAI client
client = AzureOpenAI(
    api_version="2024-06-01",
    azure_endpoint="https://admin-m8i1oz7d-eastus.openai.azure.com",
    api_key=OPENAI_API_KEY
)

# Database connection details
# Import dotenv for loading environment variables

# Load environment variables from .env file
load_dotenv()

# Database connection details from environment variables
DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),  # Will be prompted if not in env
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

# Prompt for the database password if not in environment variables
if not DB_PARAMS["password"]:
    DB_PARAMS["password"] = getpass.getpass(prompt="Enter database password: ")

# Prompt for the database password
DB_PARAMS["password"] = getpass.getpass(prompt="Enter database password: ")

# Function to get embedding from OpenAI
def get_embedding(text, model="text-embedding-ada-002"):
    try:
        response = client.embeddings.create(
            input=text,
            model=model
        )
        return response.data[0].embedding
    except Exception as e:
        logging.error(f"Error generating embedding: {e}")
        return None

# Function to perform semantic search with the given query
def perform_semantic_search(cursor, query_text, limit=5):
    logging.info(f"Performing semantic search for: '{query_text}'")
    
    # Get the embedding for the query
    query_embedding = get_embedding(query_text)
    
    if not query_embedding:
        logging.error("Failed to generate embedding for the query")
        return []
    
    # Perform the search using cosine similarity
    cursor.execute("""
        SELECT id, scenario, category, sub_category, language, role, ide_type, reference,
               1 - (embedding <=> %s) AS similarity
        FROM demo_catalog
        WHERE embedding IS NOT NULL
        ORDER BY similarity DESC
        LIMIT %s;
    """, (json.dumps(query_embedding), limit))
    
    results = cursor.fetchall()
    logging.info(f"Found {len(results)} matching results")
    return results

# Function to check if there are records needing vectorization
def check_vectorization_needed(cursor):
    cursor.execute("SELECT COUNT(*) FROM demo_catalog WHERE embedding IS NULL;")
    count = cursor.fetchone()[0]
    return count > 0

# Function to process in batches
def process_in_batches(rows, batch_size=10):
    total_rows = len(rows)
    for i in range(0, total_rows, batch_size):
        yield rows[i:i + batch_size]

try:
    # Connect to PostgreSQL
    logging.info("Connecting to database...")
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()

    # Check if vectorization is needed
    logging.info("Checking if vectorization is needed...")
    if not check_vectorization_needed(cursor):
        logging.info("Table is already fully vectorized. Proceeding with semantic search test.")
        
        # Perform semantic search test
        query_text = "Find scenarios involving junior developers writing Go tests with a JetBrains IDE."
        results = perform_semantic_search(cursor, query_text)
        
        # Display results
        print("\n=== Semantic Search Results ===")
        print(f"Query: '{query_text}'")
        print("-----------------------------------")
        
        for i, (id, scenario, category, sub_category, language, role, ide_type, reference, similarity) in enumerate(results, 1):
            print(f"Result {i}:")
            print(f"ID: {id}")
            print(f"Category: {category} / {sub_category}")
            print(f"Language: {language}")
            print(f"Role: {role}")
            print(f"IDE Type: {ide_type}")
            print(f"Reference: {reference}")
            print(f"Similarity Score: {similarity:.4f}")
            print(f"Scenario: {scenario[:100]}..." if len(scenario) > 100 else f"Scenario: {scenario}")
            print("-----------------------------------")
            
    else:
        # Select data that needs embeddings
        logging.info("Selecting records that need embeddings...")
        cursor.execute("SELECT id, points, category, sub_category, language, role, ide_type, scenario, reference FROM demo_catalog WHERE embedding IS NULL;")
        rows = cursor.fetchall()
        logging.info("Records selected successfully.")

        if not rows:
            logging.info("No records found that need embeddings.")
        else:
            logging.info(f"Found {len(rows)} records to process.")
            
            # Process in batches with progress bar
            for batch in tqdm(list(process_in_batches(rows)), desc="Processing batches"):
                for row in batch:
                    id, points, category, sub_category, language, role, ide_type, scenario, reference = row
                    
                    if not scenario:
                        logging.warning(f"Empty text for record {id}, skipping")
                        continue
                    
                    embedding = get_embedding(scenario)
                    
                    if embedding:
                        # Store in the database
                        cursor.execute(
                            "UPDATE demo_catalog SET embedding = %s WHERE id = %s",
                            (json.dumps(embedding), id)
                        )
                        
                # Commit after each batch
                conn.commit()
                
            logging.info("Processing completed successfully")

except Exception as e:
    logging.error(f"An error occurred: {e}")
    if 'conn' in locals() and conn:
        conn.rollback()
finally:
    if 'cursor' in locals() and cursor:
        cursor.close()
    if 'conn' in locals() and conn:
        conn.close()
    logging.info("Database connection closed")
