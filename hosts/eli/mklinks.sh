#!/run/current-system/sw/bin/bash
cd /etc/nixos
cp hardware-configuration.nix /root/nix-config/eli/hardware-configuration.nix
sudo mv configuration.nix configuration.nix.original
sudo mv hardware-configuration.nix hardware-configuration.nix.original
sudo ln -s /root/nix-config/eli/configuration.nix /etc/nixos/configuration.nix
sudo ln -s /root/nix-config/eli/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
