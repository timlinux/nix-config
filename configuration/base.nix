{ config,modules,pkgs,... }: 
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
  ];
  system.stateVersion = "23.11";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Enable networking
  networking.networkmanager.enable = true;

  imports = [
    ../modules/console-apps.nix
    ../modules/bootsplash.nix
    ../modules/fish.nix
    ../modules/garbage-collection.nix
    ../modules/grub-theme.nix
    ../modules/harden.nix
    ../modules/locale-pt-en.nix
    ../modules/ssh.nix
    ../modules/starship.nix
    ../modules/tailscale.nix
    ../modules/vim.nix
  ];

}
