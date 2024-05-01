{config, ...}: let
  #str2Bool = (x: if x == "dark" then false else true);
  #isLight = str2Bool config.theme.color;
  isLight = false;
in {
  config = {
    programs.ripgrep = {
      arguments = [
        "--colors=line:style:bold"
        "--max-columns-preview"
        "--smart-case"
      ];
      enable = true;
    };
  };
}
