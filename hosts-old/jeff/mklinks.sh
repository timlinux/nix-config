#!/run/current-system/sw/bin/bash
cd /etc/nixos
sudo mv configuration.nix configuration.nix.original
sudo mv hardware-configuration.nix hardware-configuration.nix.original
sudo ln -s /home/jeff/dev/nix-config/hosts/jeff/configuration.nix /etc/nixos/configuration.nix
sudo ln -s /home/jeff/dev/nix-config/hosts/jeff/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
