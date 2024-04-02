{ config, ... }:
let
  #str2Bool = (x: if x == "dark" then false else true);
  #isLight = str2Bool config.theme.color;
  isLight = false;
in {
  config = {
    programs.git = {
      enable = true;
      extraConfig = {
        core = { editor = "vim"; };
        pull = { rebase = "false"; };
        init = { defaultBranch = "main"; };
        merge = { conflictstyle = "diff3"; };
        diff = { colorMoved = "default"; };
        add.interactive = { useBuiltin = false; };
        format = {
          pretty = ''
            Commit:  %C(yellow)%H%nAuthor:  %C(green)%aN
                  <%aE>%nDate: (%C(red)%ar%Creset) %ai%nSubject: %s%n%n%b'';
        };
      };

      aliases = {
        conflict = "diff --name-only --diff-filter=U";
        s = "status";
        d = "diff";
        a = "add";
        ds = "diff --staged";
        hist = ''
          log --pretty=format:"%h %ad - %ar | %s%d [%an]" --graph
          --date=short'';
        last = "log -1 HEAD";
        today = ''
          log --since=12am --pretty=format:"%h %ad - %ar | %s%d [%an]"
          --graph --date=short'';
        graph =
          "log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset'";
      };

      delta = {
        enable = true;
        options = {
          navigate = true;
          light = isLight;
        };
      };
    };
  };
}
