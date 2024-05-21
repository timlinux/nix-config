{
  config,
  pkgs,
  ...
}: let
  # Define the TTF font to be used (e.g., Hack Nerd Font)
  fontHack = pkgs.nerdfonts.override {fonts = ["Hack"];};
  ttfFontPath = "${fontHack}/share/fonts/truetype/HackNerdFontMono-Regular.ttf";
in {
  # Ensure kmscon and the font are included in the system packages
  environment.systemPackages = with pkgs; [
    kmscon
    fontHack
  ];

  # Enable and configure kmscon service
  services.kmscon = {
    enable = true;
    #enableTTYs = ["tty1" "tty2" "tty3" "tty4" "tty5" "tty6"];
    font = ttfFontPath;
    fontSize = 24; # Set the desired font size
  };

  # Optionally, set the keymap
  # do this in the host config rather
  #console.keyMap = "us";  # Adjust to your preferred keymap
}
