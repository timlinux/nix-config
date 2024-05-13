{
  config,
  modules,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
  ];
  system.stateVersion = "23.11";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Enable networking
  #networking.networkmanager.enable = true;

  imports = [
    ../software/console-apps
    ../software/bootsplash.nix
    ../software/fish.nix
    ../software/garbage-collection.nix
    ../software/grub-theme.nix
    ../software/harden.nix
    ../software/ssh.nix
    ../software/starship.nix
    ../software/vim.nix
  ];
}
