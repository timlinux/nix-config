{ config, pkgs, ... }:
{
  ##
  ## Yubikey PAM support - see https://nixos.wiki/wiki/Yubikey
  ## 
  services.udev.packages = [ 
    pkgs.yubikey-personalization 
    #gnome.gnome-settings-daemon # app tray
  ];
  # Make sure to first do pam_u2f in above url before enabling this section
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.yubico = {
     enable = true;
     debug = true;
     mode = "challenge-response";
     # Make sure you yubikey is configured first
     # next line sets it to require both pwd and yk
     # need to read more, doesnt work
     control = "required";
  };
  # Lock screen when yubikey is removed
  # See https://nixos.wiki/wiki/Yubikey
  services.udev.extraRules = ''
      ACTION=="remove",\
       ENV{ID_BUS}=="usb",\
       ENV{ID_MODEL_ID}=="0407",\
       ENV{ID_VENDOR_ID}=="1050",\
       ENV{ID_VENDOR}=="Yubico",\
       RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
  # Yubikey ends ...
}
