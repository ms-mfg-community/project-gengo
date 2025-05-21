# Rewrite history
# Legacy: git filter-branch to remove files:

git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch path/to/sensitive_file' \
  --prune-empty --tag-name-filter cat -- --all

java -jar bfg.jar --delete-files path/to/sensitive_file.git
# or replace strings:
java -jar bfg.jar --replace-text passwords.txt
# Clean up and force-push:

git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push origin --force --all