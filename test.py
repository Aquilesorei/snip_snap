import json
import re

# Read the JSON data from a file
with open('directory_map.json') as file:
    data = json.load(file)

# Define the regex pattern
pattern = r'(men|women|salon)/(.*\.jpg|.*\.jpeg|.*\.webp)'

# Add the prefix to each image path
for category in data:
    for i, image_path in enumerate(data[category]):
        data[category][i] = 'assets/pictures/' + re.sub(pattern, r'\1/\2', image_path)

# Write the modified JSON data back to the file
with open('modified_data.json', 'w') as file:
    json.dump(data, file, indent=4)

