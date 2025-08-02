#!/bin/bash

# List of languages to analyze
LANGUAGES=("javascript" "python" "java")

# Root directory of the source code
SOURCE_ROOT="$(pwd)"

# Output directory for databases
OUTPUT_DIR="codeql-dbs"
mkdir -p "$OUTPUT_DIR"

# Loop through each language and create a separate database
for LANG in "${LANGUAGES[@]}"; do
    DB_NAME="${LANG}-db"
    echo "Creating CodeQL database for $LANG..."
    codeql database create "$OUTPUT_DIR/$DB_NAME" \
        --language="$LANG" \
        --source-root="$SOURCE_ROOT" \
        --overwrite
    echo "Database for $LANG created at $OUTPUT_DIR/$DB_NAME"
done

echo "All databases created successfully."
