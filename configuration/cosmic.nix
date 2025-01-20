{
  config,
  pkgs,
  ...
}: {
  modules = [
    {
      nix.settings = {
        substituters = ["https://cosmic.cachix.org/"];
        trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
      };
    }
    nixos-cosmic.nixosModules.default;
  ];
}
