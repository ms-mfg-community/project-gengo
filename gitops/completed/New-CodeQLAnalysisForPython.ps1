# reference: https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/about-the-codeql-cli#example-ci-configuration-for-codeql-analysis
# Show the available languages
codeql resolve languages --format=betterjson
codeql database create codeql-dbs --source-root=$(git rev-parse --show-toplevel) --language=python
codeql database analyze codeql-dbs --download codeql/python-queries --format=sarif-latest --threads=4 --sarif-category=python --output=python-results.sarif
$env:GITHUB_TOKEN | codeql github upload-results --github-auth-stdin --repository=ms-mfg-community/project-gengo --ref=refs/heads/main --commit=$(git rev-parse HEAD) --sarif=python-results.sarif