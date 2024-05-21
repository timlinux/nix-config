{ config, pkgs, ... }:

# If the network adapter does not want to start do
# sudo virsh net-start default
# Or make it default to start every time by running
# virsh net-autostart default
#
# Verify the interface is up like this
#sudo virsh net-list
# Name      State    Autostart   Persistent
#--------------------------------------------
# default   active   yes         yes
#
#
# Note that currently you cannot use virtman and 
# adguard at the same time since they fight over the
# virtual nic. So shutdown adguard before you want to 
# use virtman:
#
# sudo systemctl stop adguardhome.service  
# sudo virsh net-start default
#
# to start adguard again when you are done with virtman:
# 
# sudo virsh net-destroy default
# Network default destroyed
# sudo systemctl start adguardhome.service
#
{
  config = {
    environment.systemPackages = with pkgs; [
      libosinfo
      libvirt-glib
      spice
      spice-gtk
      spice-protocol
      virt-manager
      virt-viewer
      win-spice
      win-virtio
    ];

    programs.dconf.enable = true;

    # Manage the virtualisation services
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
