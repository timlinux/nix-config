{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    plex
  ];
  services.plex = {
    enable = true;
    enableLocalService = true; # Allow Plex to run as a local service
    ensurePackage = true; # Ensure the Plex package is installed
    systemd.tmpfiles.rules = [
      "D /var/lib/plexmediaserver 0755 plex plex" # Set permissions for the Plex data directory
    ];
  };
  networking.firewall.allowedTCPPorts = [32400];
  services.plex.dataDir = "/var/lib/plexmediaserver";
  services.plex.extraConfig = ''
    # Add any extra Plex configuration here
    # Example: enable hardware transcoding
    # UseQuickSync = 1
  '';
}
