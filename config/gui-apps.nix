{ pkgs, ... }:

{

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    blender
    deja-dup
    emote # emoji picker
    drawio
    firefox
    flameshot
    gimp
    gnome.gnome-sound-recorder
    gnome.gnome-terminal
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
    nextcloud-client
    obs-studio
    paperwork
    qtcreator
    slack
    synfigstudio
    tdesktop
    vscode
    xournalpp
    #citations
    #emblem
    #eyedropper
    #gaphor
    #lorem
    #solanum
    #zap
  ];
}

