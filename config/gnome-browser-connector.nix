{ pkgs, ... }:

{
# gnome-browser-connector-for-gnome-extensions
  environment.systemPackages = with pkgs; [
    gnome-browser-connector
  ];
}
