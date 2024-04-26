{
  system ? builtins.currentSystem,
  pkgs,
  config,
  ...
}: {
  # Unstable defined in flake.nix and overlaid to be available here
  environment.systemPackages = with pkgs; [
    unstable.vscode
  ];
}
