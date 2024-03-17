{ pkgs, ... }:

{
  # kdeconnect
  environment.systemPackages = with pkgs; [
    libsForQt5.kdeconnect-kde
  ];
}
