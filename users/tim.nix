{ pkgs, ... }:

{
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from tim.nix"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    description = "Tim Sutton";
    # dialout needed for arduino
    extraGroups = [ "wheel" "disk" "libvirtd" "dialout" "docker" "audio" "video" "input" "systemd-journal" "networkmanager" "network" "davfs2"  "adbusers" "scanner" "lp" "i2c"];

    packages = with pkgs; [
      popcorntime
      freetube
      tailscale
    ];
  };
}
