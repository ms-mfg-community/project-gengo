gh auth login -p https --web
# GitHub CLI api
# https://cli.github.com/manual/gh_api
gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /orgs/ms-mfg-community/code-scanning/alerts
# gh api -H "Accept: application/json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/ms-mfg-community/code-scanning/alerts