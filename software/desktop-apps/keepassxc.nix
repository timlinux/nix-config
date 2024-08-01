# See also this video for setting up HMAC
# YubiKey based access https://www.youtube.com/watch?v=ATvNK5LKpv8
{
  system ? builtins.currentSystem,
  pkgs,
  config,
  ...
}: {
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    # Unstable defined in flake.nix and overlaid to be available here
    keepassxc
  ];
}
