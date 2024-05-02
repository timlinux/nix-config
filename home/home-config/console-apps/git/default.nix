{config, ...}: {
  config = {
    programs.git = {
      # Set to null to let GnuPG decide what signing key to use depending on commit’s author.p
      signing.key = null;
      signing.signByDefault = true;
      enable = true;
      #enableGPGSign = true;
      # Optionally, you can specify the path to your GPG key here
      # gpgKey = "/path/to/your/gpg/key";
      extraConfig = {
        branch.autoSetupRebase = "always";
        checkout.defaultRemote = "origin";

        pull.ff = "only";
        push.default = "current";

        init.defaultBranch = "main";
        submodule.recurse = "true";

        core = {editor = "vim";};
        merge = {conflictstyle = "diff3";};
        diff = {colorMoved = "default";};
        add.interactive = {useBuiltin = false;};
        format = {
          pretty = ''
            Commit:  %C(yellow)%H%nAuthor:  %C(green)%aN
                  <%aE>%nDate: (%C(red)%ar%Creset) %ai%nSubject: %s%n%n%b'';
        };
        advice = {
          statusHints = false;
        };
        color = {
          branch = false;
          diff = false;
          interactive = true;
          log = false;
          status = true;
          ui = false;
        };
        core = {
          pager = "bat";
        };
        push = {
          default = "matching";
        };
        pull = {
          rebase = false;
        };
        init = {
          defaultBranch = "main";
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
        graph = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        ci = "commit";
        cl = "clone";
        co = "checkout";
        purr = "pull --rebase";
        dlog = "!f() { GIT_EXTERNAL_DIFF=difft git log -p --ext-diff $@; }; f";
        dshow = "!f() { GIT_EXTERNAL_DIFF=difft git show --ext-diff $@; }; f";
        fucked = "reset --hard";
      };
      difftastic = {
        display = "side-by-side-show-both";
        enable = true;
      };
      ignores = [
        ".direnv/"
        "*.log"
        "*.out"
        ".DS_Store"
        #"bin/"
        "dist/"
        "result"
      ];
    };
  };
}
