{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;

  # Currently I have issues running wayland like flashing windows etc.
  # if enabling this with the nvidia driver so be sure to 
  # switch off nvidia dribers in configuration.nix if using this
  services.xserver.displayManager.gdm.wayland = true;

  # Recompile gdm with our custom wallpaper 
  nixpkgs.overlays = [
      (self: super: {
        gnome = super.gnome.overrideScope' (selfg: superg: {
          gnome-shell = superg.gnome-shell.overrideAttrs (old: {
            patches = (old.patches or []) ++ [
              (let
                bg = pkgs.fetchurl {
                  url = "https://raw.githubusercontent.com/timlinux/nix-config/main/resources/kartoza-background.gdm.png";
                  sha256 = "";
                };
              in pkgs.writeText "bg.patch" ''
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
