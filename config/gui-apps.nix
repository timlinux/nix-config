{ pkgs, ... }:

{

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    adapta-kde-theme
    audacity
    blender
    dbeaver
    deja-dup
    emote # emoji picker
    drawio
    firefox
    flameshot
    gimp
    # Needed for gnome boxes
    qemu_kvm
    virt-manager
    gnome.gnome-boxes
    (gnome.gnome-boxes.override {
      qemu-utils = qemu-utils.override {
        qemu = qemu_kvm;
      };
    })
    gnome.gnome-tweaks
    gnome.gnome-sound-recorder
    gnome.gnome-terminal
    gnomeExtensions.notes
    gnucash
    google-chrome
    gpick
    inkscape
    kdenlive
    keepassxc
    libreoffice-fresh
    # For multilingual spell check in logseq, edit 
    # vim ~/.config/Logseq/Preferences
    # and add e.g.
    # {"spellcheck":{"dictionaries":["en-GB","pt"],"dictionary":""}}
    # TODO is to automate this with home manager....
    logseq
    mpv # videa player
    nextcloud-client
    obs-studio
    paperwork
    qtcreator
    shortwave # Internet streaming radio player
    slack
    synfigstudio
    tdesktop
    xournalpp
    citations
    emblem
    eyedropper # nice simple colour picker
    gaphor # Uml diagramming app
    #lorem
    solanum
    zap #Java application for web penetration testing
  ];
}

