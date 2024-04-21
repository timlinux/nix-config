{pkgs, ...}:
pkgs.writeShellApplication {
  name = "about";
  runtimeInputs = [
    pkgs.bash
    pkgs.gum
    pkgs.skate #a distributed key/value store
  ];
  text = builtins.readFile ./about.sh;
}
