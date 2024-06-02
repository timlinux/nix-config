{pkgs, ...}: {
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-kde-theme
    archi # CASE Modelling tool for db and system architecture design
    audacity
    barrier # Share the same keyboard and mouse on two computers
    blender
    bluefish # pretty basic html editing app
    brave
    copyq # Clipboard history manager with image support
    dbeaver-bin
    deja-dup
    drawio
    firefox
    flameshot
    gimp-with-plugins
    #nonfree
    #gitkraken # nice UI for Git
    # Needed for gnome boxes
    qemu_kvm
    virt-manager
    gnucash
    google-chrome
    ungoogled-chromium
    inkscape-with-extensions
    kdenlive
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
    pdfarranger # handy tool to rotate, join etc pdfs. Then use xournal++ to edit
    peek
    pidgin
    qpwgraph # patch bay / audio wiring for pipewire
    qtcreator
    libsForQt5.qt5.qttools # qtdesigner, assistant etc.
    schemaspy # Generate annotated schema documentation of pg and other databases
    slack
    synfigstudio
    tdesktop
    thunderbirdPackages.thunderbird-115 # Email and calendar desktop app
    tmux # needed by byobu
    xournalpp
    zap #Java application for web penetration testing
    # The following is a Qt theme engine, which can be configured with kvantummanager
    libsForQt5.qtstyleplugin-kvantum
  ];
}
