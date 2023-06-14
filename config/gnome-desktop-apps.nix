{ config, pkgs, ... }:

{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    dialect # gnome ui for google translate
    blanket # creates ambient white noise for focussed working
    authenticator # Two-factor authentication code generator for GNOME
    emote # emoji picker
    gnomeExtensions.notes
    gnomeExtensions.draw-on-you-screen-2 # Start drawing with Super+Alt+D and save your beautiful work by taking a screenshot
    gnome-decoder # Scan and Generate QR Codes
    gpick
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
    gnome.gnome-boxes
    (gnome.gnome-boxes.override {
      qemu-utils = qemu-utils.override {
        qemu = qemu_kvm;
      };
    })
  ];
}
