{ config, pkgs, ... }:
{
  # Note:
  # 
  # scrcpy is an app similar to uxplay that allows you to 
  # cast your android device to a window in linux
  #
  #
  # We make an alias below for convenient launching when using oculus quest 2

  programs.fish.shellAliases = {
    # see https://stackoverflow.com/a/73202796
    ax-oculus = "scrcpy --crop 1730:974:1934:450 --max-fps 30";
  };
  environment.systemPackages = with pkgs; [
    scrcpy
  ];
  # Enable the android debug environment too
  # On your device you also need to enable debugging....
  programs.adb.enable = true;
  # also need to add this to your profile in users/yourname.nix
  #   users.users.<your-user>.extraGroups = ["adbusers"];

}
