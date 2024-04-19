{pkgs, ...}: {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    starship init fish | source
    echo "Hello from selma.nix"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.selma = {
    isNormalUser = true;
    description = "Selma Vidimlic";
    # dialout needed for arduino
    extraGroups = ["wheel" "disk" "libvirtd" "dialout" "docker" "audio" "video" "input" "systemd-journal" "networkmanager" "network" "davfs2" "adbusers" "scanner" "lp" "i2c"];

    packages = with pkgs; [
      tailscale
    ];
  };
}
