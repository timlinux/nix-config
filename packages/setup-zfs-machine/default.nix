{ writeShellApplication, bash, gum, cryptsetup, gptfdisk, dosfstools, ... }:

writeShellApplication {
  name = "setup-host-with-zfs";
  runtimeInputs = [
    bash
    gum
    cryptsetup
    gptfdisk
    dosfstools
  ];
  text = builtins.readFile ./setup-host-with-zfs.sh;
}
