#!/usr/bin/env bash
echo "🪛 Running QGIS:"
echo "--------------------------------"

NIXPKGS_ALLOW_INSECURE=1 nix run --impure .#qgis
