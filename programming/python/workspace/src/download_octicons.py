import requests
from bs4 import BeautifulSoup
import os

# URL of the icons page
url = 'https://primer.style/foundations/icons#24px'

# Send a GET request to the URL
response = requests.get(url)
response.raise_for_status()  # Check if the request was successful

# Parse the HTML content
soup = BeautifulSoup(response.text, 'html.parser')

# Find all SVG elements
svg_elements = soup.find_all('svg')

# Create a directory to save the icons
os.makedirs('icons', exist_ok=True)

# Loop through each SVG element and save it as a file
for svg in svg_elements:
    # Get the icon name from the 'title' tag or default to 'icon'
    title_tag = svg.find('title')
    icon_name = title_tag.text if title_tag else 'icon'
    
    # Sanitize the icon name to create a valid filename
    sanitized_icon_name = "".join(c if c.isalnum() else "_" for c in icon_name)
    
    # Create the file path
    file_path = os.path.join('icons', f'{sanitized_icon_name}.svg')

    print(f"Icon Title: {icon_name}")    
    # Write the SVG content to the file
'''
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(str(svg))
'''
    # Print the title property
print("Download complete.")