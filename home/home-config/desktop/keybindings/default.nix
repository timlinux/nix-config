{
  # Tims custom keybindings
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "emote";
      command = "emote";
      binding = "<Ctrl><Alt>e";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "kitty ctrl_alt";
      command = "kitty -e tmux";
      binding = "<Ctrl><Alt>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "flameshot";
      command = "flameshot gui";
      binding = "<Ctrl>4";
    };
  };
}
