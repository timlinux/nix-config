{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  pname = "kartoza-cron";
  version = "1.0";
  src = ./.;

  buildInputs = [pkgs.bash pkgs.skate pkgs.git];

  installPhase = ''
    mkdir -p $out/bin
    cp script.sh $out/bin/kartoza-cron
    chmod +x $out/bin/kartoza-cron
  '';

  meta = with pkgs.lib; {
    description = "Script for updating NixOS and sending system stats";
    license = licenses.mit;
    maintainers = with maintainers; [timlinux];
  };
}
