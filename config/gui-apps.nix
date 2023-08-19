{ pkgs, ... }:

{

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-kde-theme
    audacity
    blender
    brave
    dbeaver
    deja-dup
    drawio
    firefox
    flameshot
    gimp-with-plugins
    # Needed for gnome boxes
    qemu_kvm
    virt-manager
    gnucash
    google-chrome
    ungoogled-chromium
    inkscape-with-extensions
    kdenlive
    keepassxc
    krita
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
    peek
    pidgin
    qtcreator
    slack
    synfigstudio
    tdesktop
    tmux # needed by byobu
    xournalpp
    zap #Java application for web penetration testing
    # The following is a Qt theme engine, which can be configured with kvantummanager
    libsForQt5.qtstyleplugin-kvantum
  ];
}

