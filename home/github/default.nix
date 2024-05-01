{config, ...}: let
  #str2Bool = (x: if x == "dark" then false else true);
  #isLight = str2Bool config.theme.color;
  isLight = false;
in {
  config = {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [gh-markdown-preview];
      settings = {
        editor = "micro";
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
