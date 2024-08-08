{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    googleearth-pro
    # TODO Need to figure out a way around the fact it's been
    # marked as insecure.
  ];
}
