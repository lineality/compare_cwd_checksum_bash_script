#!/bin/bash

# Variable to hold the reference checksum
reference_checksum=""

# Variable to keep track if all checksums are the same
all_same=1  # 1 for true, 0 for false

# The name of the script itself (to avoid checking itself)
script_name=$(basename "$0")

# Start of the script: print information about what the script will do
echo "Starting the checksum comparison for all files in the current directory..."

# Loop through all files to compute checksums and compare
for file in *; do
    if [ -f "$file" ] && [ "$file" != "$script_name" ]; then
        # Compute the checksum
        current_checksum=$(sha256sum "$file" | awk '{print $1}')
        
        # Print the checksum
        echo "Checksum for $file: $current_checksum"

        # Initialize reference_checksum if not already set
        if [ -z "$reference_checksum" ]; then
            reference_checksum=$current_checksum
        fi

        # Compare with reference
        if [ "$current_checksum" != "$reference_checksum" ]; then
            all_same=0
        fi
    fi
done

# Final output based on whether all files had the same checksum
if [ $all_same -eq 1 ]; then
    echo "All files have the same checksum."
else
    echo "Not all files have the same checksum."
fi
