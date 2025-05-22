#!/usr/bin/env python3
"""
Script to display repository contents recursively.
"""

import os
import sys
from pathlib import Path

def print_directory_structure(path, indent=0, prefix=''):
    """
    Print the directory structure starting from the specified path.
    
    Args:
        path: Directory path to print
        indent: Current indentation level
        prefix: Prefix for the current item
    """
    # Get the absolute path if not already
    if not os.path.isabs(path):
        path = os.path.abspath(path)
    
    # Print the current directory name
    if indent == 0:
        print(f"Repository contents for: {path}")
        print("=" * 80)
    else:
        print(' ' * (indent - len(prefix)) + prefix + os.path.basename(path))
    
    # If this is a directory, print its contents
    if os.path.isdir(path):
        items = sorted(os.listdir(path))
        files = []
        dirs = []
        
        # Separate directories and files
        for item in items:
            item_path = os.path.join(path, item)
            if os.path.isdir(item_path):
                dirs.append(item)
            else:
                files.append(item)
        
        # Process directories first
        for i, dirname in enumerate(dirs):
            is_last = (i == len(dirs) - 1) and not files
            new_prefix = '└── ' if is_last else '├── '
            next_indent = '    ' if is_last else '│   '
            print_directory_structure(os.path.join(path, dirname), 
                                     indent + len(new_prefix),
                                     new_prefix)
        
        # Then process files
        for i, filename in enumerate(files):
            is_last = i == len(files) - 1
            file_prefix = '└── ' if is_last else '├── '
            print(' ' * indent + file_prefix + filename)

def main():
    """
    Main entry point for the script.
    """
    # Get repository root path
    try:
        import subprocess
        repo_root = subprocess.check_output(
            ["git", "rev-parse", "--show-toplevel"], 
            universal_newlines=True
        ).strip()
    except:
        # Fallback to current working directory if git command fails
        repo_root = os.getcwd()
        print(f"Warning: Unable to determine git repository root, using current directory: {repo_root}")
    
    print_directory_structure(repo_root)

if __name__ == "__main__":
    main()
