#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <destination_path>"
    exit 1
fi

# Assign arguments to variables
source_file=template_files.txt
destination_path=$1

# Check if the source file exists
if [ ! -f "$source_file" ]; then
    echo "Error: Source file '$source_file' not found!"
    exit 1
fi

# Check if the destination path exists, if not create it
if [ ! -d "$destination_path" ]; then
    echo "Destination path '$destination_path' does not exist. Creating it..."
    mkdir -p "$destination_path"
fi

# Read each line from the source file and copy the items
while IFS= read -r item; do
    # Skip empty lines or lines with only whitespace
    if [[ -z "${item// }" ]]; then
        continue
    fi

    # Check if the item exists
    if [ -e "$item" ]; then
        echo $item
        cp -r "$item" "$destination_path"
    else
        echo "Warning: $item does not exist and will be skipped."
    fi
done < "$source_file"

