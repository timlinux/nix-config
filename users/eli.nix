{pkgs, ...}: {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    starship init fish | source
    echo "Hello from eli.nix"
  '';
  # I tried just adding this in the fish module
  # but it doesnt work so we need to add it
  # for each user
  programs.fish.interactiveShellInit = ''
    starship init fish | source
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eli = {
    isNormalUser = true;
    description = "Eli Volschenk";
    extraGroups = ["wheel" "disk" "libvirtd" "docker" "audio" "video" "input" "systemd-journal" "networkmanager" "network" "davfs2"];

    packages = with pkgs; [
    ];
  };
}
