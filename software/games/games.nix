{pkgs, ...}: {
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    warzone2100
    minetest
    atanks
  ];
}
