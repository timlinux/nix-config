{ pkgs, ... }:

{
  # For tailscale gateway host
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.ip_forward" = 1;
  
  # Add system wide packages
  environment.systemPackages = with pkgs; [
  ];
}

