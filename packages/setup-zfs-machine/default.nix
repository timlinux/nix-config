{pkgs, ...}:
pkgs.writeShellApplication {
  name = "setup-host-with-zfs";
  runtimeInputs = [
    pkgs.bash
    pkgs.gum
    pkgs.rpl
    pkgs.gptfdisk
    pkgs.dosfstools
  ];
  text = builtins.readFile ./setup-host-with-zfs.sh;
}
