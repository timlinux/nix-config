{
  system ? builtins.currentSystem,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    googleearth-pro
  ];
}

