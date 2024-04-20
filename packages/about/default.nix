{pkgs, ...}:
pkgs.writeShellApplication {
  name = "about";
  runtimeInputs = [
    pkgs.bash
    pkgs.gum
  ];
  text = builtins.readFile ./about.sh;
}
