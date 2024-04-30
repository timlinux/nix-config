{
  system ? builtins.currentSystem,
  pkgs,
  config,
  ...
}: {
  # Unstable defined in flake.nix and overlaid to be available here
  # noise suppression tool - creates a virtual mic
  environment.systemPackages = [
    unstable.deepfilternet
  ];
}
