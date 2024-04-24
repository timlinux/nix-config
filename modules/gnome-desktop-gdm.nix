{
  config,
  pkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;

  # Recompile gdm with our custom wallpaper
  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome.overrideScope' (selfg: superg: {
        gnome-shell = superg.gnome-shell.overrideAttrs (old: {
          patches =
            (old.patches or [])
            ++ [
              (let
                bg = pkgs.fetchurl {
                  # TODO change branch in URL below to main once flakes branch is merged
                  url = "https://raw.githubusercontent.com/timlinux/nix-config/flakes/resources/kartoza-background.gdm.png";
                  # nix-prefetch-github timlinux nix-config
                  sha256 = "sha256-yxU1zKHJW9RjXztvfYMTnHQT240nd28Ahkpi82Jq/Xs=";
                };
              in
                pkgs.writeText "bg.patch" ''
                  --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                  +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                  @@ -15,4 +15,5 @@ $_gdm_dialog_width: 23em;
                   /* Login Dialog */
                   .login-dialog {
                     background-color: $_gdm_bg;
                  +  background-image: url('file://${bg}');
                   }
                '')
            ];
        });
      });
    })
  ];
}
