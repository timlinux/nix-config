{
  config,
  pkgs,
  ...
}: {
  programs.dconf.enable = true;
  # This and the xgg-portal below fixes focus stealing e.g. in QGIS where file dialogs
  # appear behind the main window (I think it is this that cures it anyway)
  #xdg.portal = {
  #  enable = true;
  #  # wlr.enable = true;
  #  # gtk portal needed to make gtk apps happy
  #  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #};
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    adw-gtk3
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    recursive
    amberol
    celluloid
    eyedropper
    fractal-next # matrix chat app
    gnome.dconf-editor
    gnome.gnome-calculator
    gnome.gnome-system-monitor
    gnome.gnome-weather
    gnome.nautilus
    gnome.sushi
    adapta-gtk-theme
    qgnomeplatform # make Qt apps look like Gtk if they do not specifiy their own theme
    dialect # gnome ui for google translate
    blanket # creates ambient white noise for focussed working
    authenticator # Two-factor authentication code generator for GNOME
    emote # emoji picker
    # Currently not working
    #gnomeExtensions.draw-on-you-screen-2 # Start drawing with Super+Alt+D and save your beautiful work by taking a screenshot
    # As work around you can follow the notes here to manually install:
    # For GNOME 45+ users:
    # 1) In the terminal: git clone https://github.com/zhrexl/DrawOnYourScreen2 ~/.local/share/gnome-shell/extensions/draw-on-your-screen2@zhrexl.github.com
    # 2) restart gnome-shell: Xorg -> press Alt+F2 and r , Wayland: restart or re-login
    # 3) Enable the extension with GNOME Extensions or GNOME Tweaks application
    # 4) Press Super+Alt+D to test
    # From commentor Mohsen at https://extensions.gnome.org/extension/1683/draw-on-you-screen/
    #legacyPackages.x86_64-linux.gtop # needed for below
    #gnomeExtensions.tophat # Nice system monitor applet
    drawing # gnome native drawing app
    gnome-decoder # Scan and Generate QR Codes
    newsflash # rss feed reader
    gnome.gnome-power-manager # run as gnome-power-statistics on CLI - gives charts of battery performance
    junction # Lets you choose which browser to use to open links
    # broken in 23.11 upgrade
    #citations # Manage your bibliographies using the BibTeX format
    emblem
    gnome.gnome-tweaks
    gnome.gnome-sound-recorder
    shortwave # Internet streaming radio player
    eyedropper # nice simple colour picker
    #gaphor # Uml diagramming app
    #lorem
    solanum
    warp
    tuba
    #gnome.gnome-boxes
    #(gnome.gnome-boxes.override {
    #  qemu-utils = qemu-utils.override {
    #    qemu = qemu_kvm;
    #  };
    #})
  ];
  # Things we do not want installed
  environment.gnome.excludePackages = with pkgs.gnome; [
    # baobab      # disk usage analyzer
    # cheese      # photo booth
    # eog         # image viewer
    # epiphany    # web browser
    # gedit       # text editor
    # simple-scan # document scanner
    # totem       # video player
    yelp # help viewer
    # evince      # document viewer
    # file-roller # archive manager
    geary # email client
    # seahorse    # password manager
    # these should be self explanatory
    # gnome-calculator
    gnome-calendar
    # gnome-characters
    # gnome-clocks
    gnome-contacts
    # gnome-font-viewer
    # gnome-logs
    gnome-maps
    gnome-music
    # gnome-screenshot
    # gnome-system-monitor
    # gnome-weather
    # gnome-disk-utility
    gnome-terminal
    pkgs.gnome-connections
  ];
}
