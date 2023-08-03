#!/run/current-system/sw/bin/bash
cd /etc/nixos
#cp /etc/nixos/hardware-configuration.nix /root/nix-config/hosts/luna/hardware-configuration.nix
#cp /etc/nixos/configuration.nix /root/nix-config/hosts/luna/configuration.nix
sudo mv configuration.nix configuration.nix.original
sudo mv hardware-configuration.nix hardware-configuration.nix.original
sudo ln -s /root/nix-config/hosts/luna/configuration.nix /etc/nixos/configuration.nix
sudo ln -s /root/nix-config/hosts/luna/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
