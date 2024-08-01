{
  config,
  pkgs,
  ...
}: let
  siteUrl = "https://drive.google.com";
  appName = "Google Drive";
  iconName = "google-drive.svg";
  iconPath = "${config.home.homeDirectory}/.local/share/icons/${iconName}";
in {
  home.file."google_drive_image" = {
    source = ./${iconName};
    target = iconPath;
  };
  home.packages = with pkgs; let
    googleDriveApp = makeDesktopItem {
      name = appName;
      desktopName = appName;
      genericName = appName;
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="${siteUrl}"'';
      icon = iconPath;
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Office"];
      # Needed for the gnome panel icon to be correct
      # and not to stack with other chrome apps
      # You can find out the value to use by running
      # xprop and then clicking on the app window
      # Then set the value below to whatever WM_CLASS(STRING) is
      startupWMClass = "drive.google.com";
    };
  in [googleDriveApp];
}
