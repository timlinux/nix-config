{
  config,
  pkgs,
  ...
}:
# Quickemu / quickgui is a very nice way to run QEMU virtual machines
# with nice integration....
{
  environment.systemPackages = with pkgs; [
    quickemu
    #quickgui
  ];
}
