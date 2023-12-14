import os
import json

def create_directory_map(directory_path):
    directory_map = {}

    for root, dirs, files in os.walk(directory_path):
        relative_path = os.path.relpath(root, directory_path)
        directory_name = os.path.basename(root)
        file_paths = [os.path.join(relative_path, file) for file in files]

        if directory_name not in directory_map:
            directory_map[directory_name] = []

        directory_map[directory_name].extend(file_paths)

    return directory_map

assets_directory = "assets"
pictures_directory = os.path.join(assets_directory, "images")

if os.path.isdir(pictures_directory):
    directory_map = create_directory_map(pictures_directory)
    json_data = json.dumps(directory_map, indent=4)

    with open("directory_map.json", "w") as json_file:
        json_file.write(json_data)
        print("Directory map created successfully!")
else:
    print(f"The '{pictures_directory}' directory does not exist.")


create_directory_map(".")
