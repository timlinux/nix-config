{ config, pkgs, ... }:
{
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "1";
    src = pkgs.fetchFromGitHub {
      owner = "kartoza";
      repo = "kartoza-grub-theme";
      rev = "main";
      hash = "";
    };
    installPhase = "cp -r customize/nixos $out";
  };
}
