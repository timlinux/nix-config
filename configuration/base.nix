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
    ../software/system/kartoza-plymouth.nix
    ../software/system/kartoza-grub.nix
    ../software/system/garbage-collection.nix
    ../software/system/harden.nix
    ../software/system/ssh.nix
  ];
}
