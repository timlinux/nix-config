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
  # Special settings for nix users who want to e.g. build the QGIS 
  nix.settings = {
    download-buffer-size = 500000000; # 500 MB
    trusted-users = [ "root" "timlinux" "lova" "@wheel" "@trusted" ];
    experimental-features = [ "flakes" "nix-command" ];
    auto-optimise-store = true;
    #allow-import-from-derivation = false;
  };

}
