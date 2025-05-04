# reference: https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/about-the-codeql-cli#example-ci-configuration-for-codeql-analysis
codeql database create codeql-dbs --source-root=$(git rev-parse --show-toplevel) --language=python
# The analysis fails because the codeql/python-queries cannot be found, which appears to be a known issue at: https://github.com/github/codeql/issues/13364
codeql database analyze codeql-dbs --format=sarif-latest --threads=4 --sarif-category=python --output=python-results.sarif
# codeql github upload-results --repository=ms-mfg-community/project-gengo --ref=refs/heads/main --commit=$(git rev-parse HEAD) --sarif=python-results.sarif
