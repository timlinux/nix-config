{ config, pkgs, ... }:
{
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    allowSFTP = false; # Don't set this if you need sftp
    kbdInteractiveAuthentication = false;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };
}
