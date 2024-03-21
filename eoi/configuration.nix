{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ./nginx.nix # generated at runtime by nixos-infect
    ./jupyter-reverse-proxy.nix # generated at runtime by nixos-infect
    
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "eoint";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVfPhUSJj8/5x7AEaZkfn35RwxtcPYK1aYK9+tafxU/'' ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJm3ACcKCTZq0IcCB6pIXudFiW35/PfUQlMrX5DLrZ5H'' ];
  users.users.gis = {
    openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVfPhUSJj8/5x7AEaZkfn35RwxtcPYK1aYK9+tafxU/'' ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJm3ACcKCTZq0IcCB6pIXudFiW35/PfUQlMrX5DLrZ5H'' ];
    isNormalUser = true;
    description = "GIS User";
    extraGroups = [ "wheel" "disk" "libvirtd" "dialout" "docker" "audio" "video" "input" "systemd-journal" "networkmanager" "network"     "davfs2"  "adbusers" "scanner" "lp" "i2c"];

    packages = with pkgs; [
    ];
  };
  system.stateVersion = "23.11";
  environment.systemPackages = with pkgs; [
    git
    vim
    direnv
  ];
  networking.firewall.allowedTCPPorts = [ 8888 ];
  networking.firewall.allowedUDPPorts = [ 8888 ];
}
