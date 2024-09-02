# Kindly copied from https://github.com/oddlama/nix-config/blob/main/nix/installer-configuration.nix
{pkgs, ...}: {
  system.stateVersion = "23.11";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  #console.keyMap = "de-latin1-nodeadkeys";
  console.keyMap = "pt-latin1";

  boot.loader.systemd-boot.enable = true;

  users.users.root = {
    password = "nixos";
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./users/public-keys/id_ed25519_tim.pub)
    ];
  };

  environment = {
    variables.EDITOR = "vim";
    systemPackages = with pkgs; [
      vim
      gum
      skate

      git
      tmux
      parted
      ripgrep
      fzf
      wget
      curl
    ];

    etc.issue.text = ''
      \d  \t
      This is \e{cyan}\n\e{reset} [\e{lightblue}\l\e{reset}] (\s \m \r)
      \e{halfbright}\4\e{reset} \e{halfbright}\6\e{reset}
    '';
  };
}
