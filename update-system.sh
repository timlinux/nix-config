#!/bin/bash

# Fetch latest changes and deploy
# Expects this repo to be checked out in /root/nix-config
# Tim Sutton 2023

cd /root/nix-config
nix-shell -p git --run "git pull"
