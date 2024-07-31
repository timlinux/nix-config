{
  config,
  pkgs,
  ...
}: {
  # pycharm-professional edition
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm-professional
  ];
}
