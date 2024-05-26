#!/usr/bin/env python3
import os
import re

# Directory containing the rendered images
output_dir = "/home/timlinux/dev/nix/nix-config/packages/kartoza-plymouth/src/kartoza/images/animation"

# List all files in the directory
files = os.listdir(output_dir)

# Regular expression to match files with padded zeros
pattern = re.compile(r"(.*)\.(\d+)\.(png|jpg|jpeg|tif|tiff)")

# Dictionary to hold base names and corresponding numbers
file_dict = {}

for filename in files:
    match = pattern.match(filename)
    if match:
        base, number, ext = match.groups()
        print (base, number, ext)	
        if base not in file_dict:
            file_dict[base] = []
        file_dict[base].append((int(number), ext, filename))

# Rename the files in sequence
for base, items in file_dict.items():
    items.sort()  # Sort by the original number
    for new_number, (original_number, ext, filename) in enumerate(items, start=1):
        new_filename = f"{base}.{new_number}.{ext}"
        old_filepath = os.path.join(output_dir, filename)
        new_filepath = os.path.join(output_dir, new_filename)
        os.rename(old_filepath, new_filepath)

print("Renaming completed.")
