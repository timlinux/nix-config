#!/usr/bin/env bash

# Rename files
for file in kartoza-synfig-bootsplash.*.png; do
        # Remove leading zeros
        new_filename=$(echo "$file" | sed 's/splash.000/splash./')
        # Rename the file
        mv "$file" "$new_filename"
        echo "Renamed $file to $new_filename"
done
for file in kartoza-synfig-bootsplash.*.png; do
        # Remove leading zeros
        new_filename=$(echo "$file" | sed 's/splash.00/splash./')
        # Rename the file
        mv "$file" "$new_filename"
        echo "Renamed $file to $new_filename"
done
for file in kartoza-synfig-bootsplash.*.png; do
        # Remove leading zeros
        new_filename=$(echo "$file" | sed 's/splash.0/splash./')
        # Rename the file
        mv "$file" "$new_filename"
        echo "Renamed $file to $new_filename"
done
cp kartoza-synfig-bootsplash..png kartoza-synfig-bootsplash.0.png
mv kartoza-synfig-bootsplash..png kartoza-synfig-bootsplash.300.png
