{ config, pkgs, ... }:

{
  # Needed for gnome boxes and virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    qgnomeplatform # make Qt apps look like Gtk if they do not specifiy their own theme
    dialect # gnome ui for google translate
    blanket # creates ambient white noise for focussed working
    authenticator # Two-factor authentication code generator for GNOME
    emote # emoji picker
    gnomeExtensions.dash-to-dock-for-cosmic
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
