{ pkgs, config, ... }: {
  users.users.demo.isNormalUser = true;
  services.getty.autologinUser = "demo";
  system.stateVersion = "23.05";

  environment.systemPackages = with pkgs; [
    neofetch
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.demo = {
    home.stateVersion = "23.05";
    programs.newsboat = {
      enable = true;
      urls = [{ url = "https://lhf.pt/atom.xml"; }];
    };
  };
}
