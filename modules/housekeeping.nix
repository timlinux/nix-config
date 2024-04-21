{ pkgs, ... }:

{

  # Set how many old kernels to keep around
  # if you dont set this, eventually /boot/efi will fill up
  boot.loader.systemd-boot.configurationLimit = 12;
  
  
  # Automatically clean up
  nix.gc.automatic = true;

}
