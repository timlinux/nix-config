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
    extraGroups = [ "wheel" "disk" "libvirtd" "docker" "audio" "video" "input" "systemd-journal" "networkmanager" "network" "davfs2" ];

    packages = with pkgs; [
      hugo
      popcorntime
    ];
  };
}
