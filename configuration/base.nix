{
  config,
  modules,
  pkgs,
  lib,
  ...
}: {
  options.osPrefix = lib.mkOption {
    type = lib.types.str;
    default = "timos";
    description = "Prefix for os-related system modules. Currently defaults to kartoza. Can also be timos.";
  };

  config = {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      home-manager
    ];
    system.stateVersion = "23.11";
    systemd.coredump.enable = false;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;

    imports = [
      ../software/console-apps
      ../software/system/${config.osPrefix}-plymouth.nix
      ../software/system/${config.osPrefix}-grub.nix
      ../software/system/kartoza-cron.nix
      ../software/system/garbage-collection.nix
      ../software/system/harden.nix
      ../software/system/ssh.nix
    ];
  };
}
