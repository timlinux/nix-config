{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../config/docker.nix
      ../../config/tailscale.nix
      ../../config/python.nix
      ../../config/vim.nix
      ../../config/starship.nix
      ../../config/syncthing.nix
      ../../config/locale-pt-en.nix
      ../../config/ssh.nix
      ../../config/console-apps.nix
      ../../users/tim.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";


  networking.hostName = "valley"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
     3000 # adguard admin web ui - only needed for initial setup
     8123 # home assistant
     53   # DNS - adguard
     80   # http - adguard
     443  # https - adguard
  ];
  networking.firewall.allowedUDPPorts = [ 
     53   # DNS - adguard
  ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ### 
  ### Additions by Tim (see also pkgs sections above)
  ###
  
  ### Flakes support
      
  ### See https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
