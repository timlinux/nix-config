{config, ...}: let
  #str2Bool = (x: if x == "dark" then false else true);
  #isLight = str2Bool config.theme.color;
  isLight = false;
in {
  config = {
    programs.powerline-go = {
      enable = true;
      settings = {
        cwd-max-depth = 5;
        cwd-max-dir-size = 12;
        max-width = 60;
      };
    };
  };
}
