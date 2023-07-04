{ pkgs, ... }:

{
  # Add system wide fonts
  environment.systemPackages = with pkgs; [
    maple-mono-NF
    nerdfonts
  ];
  # Note from https://nixos.wiki/wiki/Fonts
  # Despite looking like normal packages, simply adding these 
  # font packages to your environment.systemPackages won't make 
  # the fonts accessible to applications. To achieve that, put 
  # these packages in the fonts.fonts NixOS options list instead. 
  # 
  fonts.fonts = with pkgs; [
    # bitmap
    cooper-hewitt
    dina-font
    fira
    fira-code
    fira-code
    fira-code-symbols
    fira-code-symbols
    ibm-plex
    iosevka
    jetbrains-mono
    liberation_ttf
    maple-mono-NF
    mplus-outline-fonts.githubRelease
    nerdfonts 
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    powerline-fonts
    proggyfonts
    spleen
    victor-mono
  ];
}

