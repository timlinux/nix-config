{ pkgs, ... }:

{
      imports = [ 
        ./kitty/default.nix
        ./direnv/default.nix
        ./git/default.nix
      ];
}

