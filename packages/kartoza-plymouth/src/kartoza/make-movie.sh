#!/usr/bin/env bash

#!/bin/bash

#!/bin/bash

# Set the input folder and output file name
input_folder="./images/animation"
output_file="./kartoza.mp4"

# Generate the video using FFmpeg
ffmpeg -framerate 30 -pattern_type glob -i "$input_folder/*.png" -c:v libx264 -pix_fmt yuv420p "$output_file"

echo "Video saved as: ${output_file}"
