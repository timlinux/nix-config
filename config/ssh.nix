{ config, pkgs, ... }:
{
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = true;
    allowSFTP = true; # Don't set this if you need sftp
    kbdInteractiveAuthentication = true;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };
}
