{ pkgs, ... }:

{
  environment.etc = {
    "sanoid/sanoid.conf".source = ./sanoid.conf;
  };
  services.syncoid = {
    enable = true;
    interval = "*:0/15";
    commands = {
      "NIXROOT/home" = {
      target = "b/home";
      sendOptions = "w";
      extraArgs = [ "--debug" ];
    };
    #localSourceAllow =
    #   options.services.syncoid.localSourceAllow.default ++ [ "mount" ];
    #localTargetAllow =
    #   options.services.syncoid.localTargetAllow.default ++ [ "destroy" ];
    };
  };
  environment.systemPackages = with pkgs; [
    pv # needed for backups
    sanoid
  ];
}
