{ config, pkgs, ... }:
{
  # Configure keymap in X11
  services.xserver = {
    layout = "pt";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Set your time zone.
  time.timeZone = "Europe/Sarajevo";

  # This will set the UI language for Gnome
  i18n.defaultLocale = "en_US.UTF-8";

  # Select internationalisation properties.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ba.UTF-8";
    LC_IDENTIFICATION = "ba.UTF-8";
    LC_MEASUREMENT = "ba.UTF-8";
    LC_MONETARY = "ba.UTF-8";
    LC_NAME = "ba.UTF-8";
    LC_NUMERIC = "ba.UTF-8";
    LC_PAPER = "ba.UTF-8";
    LC_TELEPHONE = "ba.UTF-8";
    LC_TIME = "ba.UTF-8";
  };
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.ba
    aspellDicts.uk 
  ];
}
