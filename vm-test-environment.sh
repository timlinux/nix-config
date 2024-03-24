#!/usr/bin/env bash

echo "🏃Running config in a test vm"
rm *.qcow2
#nixos-rebuild build-vm --flake .#myhost && result/bin/run-*-vm
NIXOS_CONFIG=$PWD/hosts/test/configuration.nix NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild build-vm && result/bin/run-*-vm
#NIXOS_CONFIG=$PWD/hosts/test/configuration.nix NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild build-vm-with-bootloader && result/bin/run-*-vm
