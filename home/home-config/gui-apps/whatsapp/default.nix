# Copied from https://github.com/TLATER/dotfiles/blob/7ce77190696375aab3543f7365d298729a548df5/home-config/config/graphical-applications/whatsapp.nix
{config, ...}: {
  programs.firefox.webapps.whatsapp = {
    url = "https://web.whatsapp.com";
    id = 3;
    # TODO: Softcode user
    extraSettings = config.programs.firefox.profiles.${config.home.username}.settings;

    categories = ["Network" "InstantMessaging"];
  };
  xdg.configFile."hello/world".text = ''
    Hello, ${config.home.username}!
  '';
}
