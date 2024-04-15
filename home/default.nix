{ pkgs, ... }:

{
      imports = [ 
        ./kitty/default.nix
        ./starship/default.nix
        ./direnv/default.nix
        ./xdg/default.nix
        ./git/default.nix
      ];
}

