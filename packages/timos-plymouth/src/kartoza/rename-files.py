#!/usr/bin/env python3
import os
import re

def rename_files_in_directory(directory):
    # List all files in the directory
    files = os.listdir(directory)

    # Regular expression to match PNG files with padded zeros
    pattern = re.compile(r"(.*)\.(\d+)\.png")

    # Dictionary to hold base names and corresponding numbers
    file_dict = {}

    for filename in files:
        match = pattern.match(filename)
        if match:
            base, number = match.groups()
            if base not in file_dict:
                file_dict[base] = []
            file_dict[base].append((int(number), filename))

    # Rename the files in sequence
    for base, items in file_dict.items():
        items.sort()  # Sort by the original number
        for new_number, (original_number, filename) in enumerate(items, start=0):
            new_filename = f"{base}.{new_number}.png"
            old_filepath = os.path.join(directory, filename)
            new_filepath = os.path.join(directory, new_filename)
            print (f"Renaming {old_filepath} to {new_filepath}")
            os.rename(old_filepath, new_filepath)

    print("Renaming completed.")

if __name__ == "__main__":
    output_dir = "/home/timlinux/dev/nix/nix-config/packages/kartoza-plymouth/src/kartoza/images/animation"
    rename_files_in_directory(output_dir)
