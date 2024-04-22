{pkgs, ...}:
pkgs.writeShellApplication {
  name = "utils";
  runtimeInputs = [
    pkgs.bash
    pkgs.gum
    pkgs.skate #a distributed key/value store
  ];
  text = builtins.readFile ./utils.sh;
}
