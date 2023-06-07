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
    fira-code
    fira
    cooper-hewitt
    ibm-plex
    jetbrains-mono
    iosevka
    # bitmap
    spleen
    fira-code-symbols
    powerline-fonts
    nerdfonts 
    maple-mono-NF
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}

