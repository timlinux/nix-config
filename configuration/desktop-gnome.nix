{ config,pkgs,... }: 
{
  imports = [
    ./desktop-base.nix
    #../modules/ccache.nix
    #../modules/cron-crest.nix
    ../modules/dir-env.nix
    #../modules/distrobox.nix
    ../modules/docker.nix
    ../modules/fwupd.nix
    ../modules/fonts.nix
    ../modules/games.nix
    ../modules/display-server.nix
    #../../../modules/kde-plasma6.nix
    ../modules/gnome-desktop-wayland.nix
    ../modules/gnome-desktop-gdm.nix
    ../modules/gnome-desktop-apps.nix
    ../modules/gnome-desktop-extensions.nix
    ../modules/gnome-desktop-themes.nix
  ];
}
