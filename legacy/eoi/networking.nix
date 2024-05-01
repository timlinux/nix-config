{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    #defaultGateway = "172.31.1.1";
    #defaultGateway6 = {
    #  address = "fe80::1";
    #  interface = "eth0";
    #};
    dhcpcd.enable = true;
    usePredictableInterfaceNames = lib.mkForce false;
    #interfaces = {
    #  eth0 = {
    #    ipv4.addresses = [
    #      { address="135.181.106.77"; prefixLength=32; }
    #    ];
    #    ipv6.addresses = [
    #      { address="2a01:4f9:c012:b864::1"; prefixLength=64; }
#{ address="fe80::9400:3ff:fe1a:647f"; prefixLength=64; }
    #    ];
    #    ipv4.routes = [ { address = "172.31.1.1"; prefixLength = 32; } ];
    #    ipv6.routes = [ { address = "fe80::1"; prefixLength = 128; } ];
    #  };
      
    #};
  };
  #services.udev.extraRules = ''
  #  ATTR{address}=="96:00:03:1a:64:7f", NAME="eth0"
    
  #'';
}
