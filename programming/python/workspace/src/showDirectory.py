import os

def list_current_directory():
    current_directory = os.getcwd()
    files_and_directories = os.listdir(current_directory)
    return files_and_directories

if __name__ == "__main__":
    items = list_current_directory()
    for item in items:
        print(item)