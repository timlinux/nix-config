{pkgs, ...}: {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from jeff.nix"
  '';
  # I tried just adding this in the fish module
  # but it doesnt work so we need to add it
  # for each user
  programs.fish.interactiveShellInit = ''
    starship init fish | source
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeff = {
    isNormalUser = true;
    description = "Jeff";
    # dialout needed for arduino
    extraGroups = ["wheel" "disk" "libvirtd" "dialout" "docker" "audio" "video" "input" "systemd-journal" "networkmanager" "network" "davfs2" "adbusers" "scanner" "lp"];

    packages = with pkgs; [
    ];
  };
}
