#!/run/current-system/sw/bin/bash
cd /etc/nixos
sudo mv configuration.nix configuration.nix.original
sudo mv hardware-configuration.nix hardware-configuration.nix.original
sudo ln -s /home/timlinux/dev/nix-config/waterfall/configuration.nix /etc/nixos/configuration.nix
sudo ln -s /home/timlinux/dev/nix-config/waterfall/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
