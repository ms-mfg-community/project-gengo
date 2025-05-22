#!/usr/bin/env python3
"""
Script to display the entire repository contents recursively from the top level.
"""

import os
import sys
from pathlib import Path

def display_directory_contents(root_dir, indent=0):
    """
    Recursively display the directory contents with indentation.
    """
    # Get the absolute path of the root directory
    root_path = Path(root_dir).absolute()
    
    print(f"Displaying contents of: {root_path}")
    print("-" * 50)
    
    for item in sorted(os.listdir(root_path)):
        full_path = root_path / item
        
        # Skip hidden files/directories (starting with .) except .github
        if item.startswith('.') and item != '.github':
            continue
            
        if full_path.is_dir():
            print(" " * indent + f"📁 {item}/")
            display_directory_contents(full_path, indent + 4)
        else:
            print(" " * indent + f"📄 {item}")

def main():
    """
    Main function to determine the root directory and display its contents.
    """
    # For GitHub Actions workflow, use the GITHUB_WORKSPACE environment variable
    # which points to the root of the repository
    if 'GITHUB_WORKSPACE' in os.environ:
        root_dir = os.environ['GITHUB_WORKSPACE']
    else:
        # If not running in GitHub Actions, use the current directory or one specified
        if len(sys.argv) > 1:
            root_dir = sys.argv[1]
        else:
            root_dir = os.getcwd()
    
    print(f"Repository Root: {root_dir}")
    print("=" * 50)
    display_directory_contents(root_dir)

if __name__ == "__main__":
    main()
