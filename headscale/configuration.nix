{ pkgs, config, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ./nginx.nix # generated at runtime by nixos-infect
    ./headscale.nix # generated at runtime by nixos-infect
    ./tailscale-client.nix # generated at runtime by nixos-infect
    
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "headscale";
  networking.domain = "qgis.org";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJm3ACcKCTZq0IcCB6pIXudFiW35/PfUQlMrX5DLrZ5H'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDhh7acl0+beEpzAj6qtjikAvyIA9QMJ4A35SV5BoR6U2eorQD8Fx3SVLYl814DvtG9MaCUKR9O33BA3/96iJTqkDNGR420ta0dPae7F+0XlUKzPva1pqO9txAoxGVGy5wfNBz4JkI3sFywMFzyFqzwTCDo1/lUfLk8ipXEgWQw8mNzy4dAlBhu+FOeJWcHvH9/Sdl78YyX/PTuHmDCRPitoVymQ3REH9J6Q7FC6qF9F8sTbJchZPQpLWMfwuZjz1AqWlbVGijdmvHXdcQf1Xc/NiSO5h3kSCLKidn3S3cTOmDVkSKSTNp1H9rqo1wGg3nx+Hv53WL1USlz0gCKggYrsepZbdNbTCnx3cb7uFJTgH9gdq521QbBECipd7aTNp/evzt4vPhR/eARK6nB9lcg6Wi2DHm27fu7SQ4FTj2pthLkj231aEvMCk6mb7qNVlCq5z7cvps5fLw6qeKsorG5iJ6Cy4hKtvi76KY9ZEEH/1QiN39LlJsb1uSldGp4Xi6cdFYcw6Z2UD27+lmMmZAljyRZAPro3WKamrTTXV52sXzTPxJNO4twwOjBrU7XwcR3mQ0GcTqqXaWZnuqnvPWKmixFiqkxoJPCfh6xLQ/EF/wmdrIqfh2y0CNfVYXL5aDDhDpi4rIyh0FdH9Zt0kVoj9NvClbJlE+jTI1cVT6Miw=='' ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5DsOUwjrIGoD+RQT1s6IkYLP+DRhG16NclcNfPHgzZ'' ];
  system.stateVersion = "23.11";

  environment.systemPackages = with pkgs; [
    git
    vim
    tailscale
  ];
  # Open network ports
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
  # Example of doing it for a specific interface
  networking.firewall.interfaces."eth0".allowedTCPPorts = [ 80 443 ];
  networking.firewall.interfaces."eth0".allowedUDPPorts = [ 80 443 ];

}
