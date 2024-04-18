{ pkgs, ... }:

{
      imports = [ 
        ./gtk/default.nix
        ./kitty/default.nix
        # Broken, use the module approach rather
        #./starship/default.nix
        ./direnv/default.nix
        ./xdg/default.nix
        ./git/default.nix
      ];
}

