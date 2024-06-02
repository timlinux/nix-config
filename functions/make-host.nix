{
  nixpkgs,
  overlay-unstable,
  shared-modules,
  specialArgs,
  system,
}: hostName:
nixpkgs.lib.nixosSystem {
  specialArgs = specialArgs;
  system = system;
  modules =
    [
      ({
        config,
        pkgs,
        ...
      }: {nixpkgs.overlays = [overlay-unstable];})
    ]
    ++ shared-modules
    ++ [../hosts/${hostName}.nix];
}
