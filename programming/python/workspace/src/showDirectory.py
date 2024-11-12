import os

def show_directory_contents():
    current_directory = 'C:\\onedrive-prsn\\OneDrive\\02.00.00.GENERAL\\repos\\git\\project-gengo\\programming'
    print(f"Contents of the directory '{current_directory}':")
    for item in os.listdir(current_directory):
        print(item)

if __name__ == "__main__":
    show_directory_contents()