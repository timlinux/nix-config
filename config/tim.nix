{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    description = "Tim Sutton";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      git
      imagemagickBig
      ffmpeg_5-full
      mc
      ncdu
      wget
      deja-dup
      inkscape
      drawio
      libreoffice-fresh
      flameshot
      # For multilingual spell check in logseq, edit 
      # vim ~/.config/Logseq/Preferences
      # and add e.g.
      # {"spellcheck":{"dictionaries":["en-GB","pt"],"dictionary":""}}
      # TODO is to automate this with home manager....
      logseq
      vscode
      hugo
      gimp
      gnome3.gnome-tweaks 
      # After unstalling do
      # systemctl --user enable syncthing
      # See also https://discourse.nixos.org/t/syncthing-systemd-user-service/11199
      syncthing
      synfigstudio
      kdenlive
      obs-studio
      qtcreator
      slack
      google-chrome
      nextcloud-client
      tdesktop
      paperwork
      gnome.gnome-software
      keepassxc
      gotop
      nethogs
      iftop
      blender
      gnome.gnome-terminal
      starship
      btop
      gnucash
      maple-mono-NF
      #maple-mono-SC-NF
      nerdfonts
      xournalpp
      #citations
      #emblem
      #eyedropper
      #gaphor
      #lorem
      #solanum
      #zap
      aspell
      aspellDicts.en
      aspellDicts.uk 
      aspellDicts.pt_PT
    ];
  };
}
