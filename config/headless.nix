{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    description = "Tim Sutton";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
      git
      mc
      ncdu
      wget
      hugo
      syncthing
      gotop
      nethogs
      iftop
      starship
      btop
      aspell
      aspellDicts.en
      aspellDicts.uk 
      aspellDicts.pt_PT

    ];

  };
}
