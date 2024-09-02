{
  config,
  pkgs,
  ...
}: {
  # Pantheon
  services.xserver.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;
  services.xserver.displayManager.lightdm.greeters.pantheon.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.pantheon.apps.enable = true;
  environment.systemPackages = with pkgs; [
    pantheon-tweaks
  ];
  # see notes here for further config options
  # https://nixos.org/manual/nixos/stable/index.html#sec-pantheon-wingpanel-switchboard

  # IF the theming is screwed up:
  #  Open Switchboard and go to:
  # Administration → About → Restore Default Settings → Restore Settings.
  # This will reset any dconf settings to their Pantheon defaults.
  # Note this could reset certain GNOME specific preferences if that desktop was used prior.

  # If the appcenter is missing apps:
  #flatpak remote-add --if-not-exists appcenter https://flatpak.elementary.io/repo.flatpakrepo
}
