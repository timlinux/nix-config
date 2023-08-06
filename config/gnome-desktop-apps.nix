{ config, pkgs, ... }:

{
  # Needed for gnome boxes and virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  # This and the xgg-portal below fixes focus stealing e.g. in QGIS where file dialogs
  # appear behind the main window (I think it is this that cures it anyway)
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    qgnomeplatform # make Qt apps look like Gtk if they do not specifiy their own theme
    dialect # gnome ui for google translate
    blanket # creates ambient white noise for focussed working
    authenticator # Two-factor authentication code generator for GNOME
    emote # emoji picker
    xdg-desktop-portal-gtk
    gnomeExtensions.notes
    gnomeExtensions.draw-on-you-screen-2 # Start drawing with Super+Alt+D and save your beautiful work by taking a screenshot
    gnome-decoder # Scan and Generate QR Codes
    newsflash # rss feed reader
    gnome.gnome-power-manager # run as gnome-power-statistics on CLI - gives charts of battery performance
    gpick
    junction # Lets you choose which browser to use to open links
    citations # Manage your bibliographies using the BibTeX format
    emblem
    gnome.gnome-tweaks
    gnome.gnome-sound-recorder
    gnome.gnome-terminal
    shortwave # Internet streaming radio player
    eyedropper # nice simple colour picker
    gaphor # Uml diagramming app
    #lorem
    solanum
    warp
    virt-manager
    gnome.gnome-boxes
    (gnome.gnome-boxes.override {
      qemu-utils = qemu-utils.override {
        qemu = qemu_kvm;
      };
    })
  ];
}
