#!/run/current-system/sw/bin/bash
cd /etc/nixos
cp /etc/nixos/hardware-configuration.nix /root/nix-config/hosts/amy/hardware-configuration.nix
sudo mv configuration.nix configuration.nix.original
sudo mv hardware-configuration.nix hardware-configuration.nix.original
sudo ln -s /root/nix-config/hosts/amz/configuration.nix /etc/nixos/configuration.nix
sudo ln -s /root/nix-config/hosts/amz/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
