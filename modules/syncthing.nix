{pkgs, ...}: {
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    # After installing do
    # systemctl --user enable syncthing
    # See also https://discourse.nixos.org/t/syncthing-systemd-user-service/11199
    syncthing
  ];
}
