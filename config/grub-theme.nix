{ config, pkgs, ... }:
{
  # Inspired by https://discourse.nixos.org/t/grub-theme-help/24384/2
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "1";
    src = pkgs.fetchFromGitHub {
      owner = "kartoza";
      repo = "kartoza-grub-theme";
      rev = "main";
      hash = "sha256-wQCyO7Tqtz28ewDH21rVbE0lHRvGpDH9bq/Iop3vwxc=";
    };
    installPhase = "ls -lah themes; mkdir nixos; tar -xf themes/nixos.tar -C nixos; ls -lah; cp -r nixos $out/";
  };
}
