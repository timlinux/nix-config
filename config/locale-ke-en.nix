{ config, pkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.uk 
  ];
}
