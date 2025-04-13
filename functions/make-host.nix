{
  nixpkgs,
  geospatial-nix,
  shared-modules,
  specialArgs,
  system,
}: hostName:
nixpkgs.lib.nixosSystem {
  specialArgs = specialArgs;
  system = system;
  modules =
    [
    ]
    ++ shared-modules
    ++ [../hosts/${hostName}.nix];
}
