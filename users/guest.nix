{ pkgs, ... }:

{
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from guest.nix"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.guest = {
    isNormalUser = true;
    initialPassword = "guest";
    description = "Guest User";
    # dialout needed for arduino
    extraGroups = [ "audio" "video" "input"];
    packages = with pkgs; [
    ];
  };
  home-manager = {
    users.guest.home.stateVersion = "23.11";
    users.guest = {
      imports = [
        ../home/default.nix
      ];
    };
  };
}
