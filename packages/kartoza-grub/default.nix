{
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  # Credit to https://github.com/vinceliuice/grub2-themes/tree/master
  # for the original theme
  pname = "kartoza-grub-theme";
  version = "1";

  src = ./src;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    ls -lah $src
    cp -r $src/kartoza/* $out/

    runHook postInstall
  '';

  meta = {
    description = "Kartoza Grub Theme";
    homepage = "https://github.com/timlinux/nix-config";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [timlinux];
  };
}
