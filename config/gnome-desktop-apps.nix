{ config, pkgs, ... }:

{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    emote # emoji picker
    gnomeExtensions.notes
    gpick
    citations
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
