{
  config,
  modules,
  pkgs,
  specialArgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
  ];
  system.stateVersion = "23.11";
  systemd.coredump.enable = false;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Inherit plymouth and grub theme from flake

  imports = [
    specialArgs.kartozaThemes.plymouth
    specialArgs.kartozaThemes.grub
    ../software/console-apps
    ../software/system/kartoza-plymouth.nix
    ../software/system/kartoza-grub.nix
    ../software/system/kartoza-cron.nix
    ../software/system/garbage-collection.nix
    ../software/system/harden.nix
    ../software/system/ssh.nix
  ];
}
