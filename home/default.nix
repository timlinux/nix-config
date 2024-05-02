{
  pkgs,
  config,
  ...
}: {
  home.file."Kartoza.txt".text = "This computer is property of Kartoza.com";
  programs = {
    gpg.enable = true;
    home-manager.enable = true;
    info.enable = true;
    jq.enable = true;
    nix-index.enable = true;
    aria2.enable = true;
  };

  imports = [
    ./home-config
  ];
}
