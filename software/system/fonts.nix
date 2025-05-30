{pkgs, ...}: {
  # Add system wide fonts
  # Note from https://nixos.wiki/wiki/Fonts
  # Despite looking like normal packages, simply adding these
  # font packages to your environment.systemPackages won't make
  # the fonts accessible to applications. To achieve that, put
  # these packages in the fonts.fonts NixOS options list instead.
  #

  fonts = {
    packages = with pkgs;
      [
        # bitmap
        cooper-hewitt
        dina-font
        fira
        fira-code
        fira-code-symbols
        font-awesome
        ibm-plex
        iosevka
        jetbrains-mono
        liberation_ttf
        maple-mono.NF
        mplus-outline-fonts.githubRelease
        noto-fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        open-dyslexic
        open-sans
        powerline-fonts
        proggyfonts
        source-han-sans
        source-han-sans-japanese
        source-han-serif-japanese
        spleen
        victor-mono
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };
}
