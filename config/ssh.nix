{ config, pkgs, ... }:
{
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    allowSFTP = false; # Don't set this if you need sftp
    #settings.KbdInteractiveAuthentication = false;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
    openssh.authorizedKeysFiles = ["~/.ssh/authorized_keys"];
    openssh.passwordAuthentication = false; # originally true
    openssh.permitRootLogin = "no";
    openssh.challengeResponseAuthentication = false;
  };
}
