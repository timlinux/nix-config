{ pkgs, ... }:

{
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from luna.nix"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luna = {
    isNormalUser = true;
    description = "Luna Asefaw";
    extraGroups = [ "wheel" "disk" "libvirtd" "docker" "audio" "video" "input" "systemd-journal" "networkmanager" "network" "davfs2"  "adbusers" "scanner" "lp" ];

    packages = with pkgs; [
      hugo
      popcorntime
    ];
  };
}
