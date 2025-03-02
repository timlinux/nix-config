{
  config,
  pkgs,
  ...
}: {
  # Enable the GNOME Desktop Remote Desktop Environment.
  systemd.services."gnome-remote-desktop".wantedBy = ["graphical.target"];
  # TODO Make this available only to vpn
  networking.firewall = {
    allowedTCPPorts = [3389];
    allowedUDPPorts = [3389];
  };
}
