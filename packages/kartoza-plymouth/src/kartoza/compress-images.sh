nix-shell -p pngcrush --run 'for file in *.png; do pngcrush -ow "$file"; done'
