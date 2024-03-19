{ config, pkgs, ... }:

# If the network adapter does not want to start do
# sudo virsh net-start default

{
  # Needed for gnome boxes and virt-manager
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    # Fix for network adapter not being available
    # probably not needed
    libvirt-glib
  ];

}
