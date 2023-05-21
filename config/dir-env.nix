# Direnv will drop you into a shell with your dev packages loaded
# Please read this as you need to set up and env file too
# https://github.com/nix-community/nix-direnv#via-configurationnix-in-nixos
# # put this in ~/.config/direnv/direnvrc
# source /run/current-system/sw/share/nix-direnv/direnvrc
{ pkgs, ... }: {
  environment.interactiveShellInit = ''
    eval "$(direnv hook bash)"
  '';
  environment.systemPackages = with pkgs; [ direnv nix-direnv ];
  # nix options for derivations to persist garbage collection
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  # if you also want support for flakes
  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; } )
  ];
}
