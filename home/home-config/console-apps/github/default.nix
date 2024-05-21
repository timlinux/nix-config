{
  config,
  pkgs,
  ...
}: {
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
