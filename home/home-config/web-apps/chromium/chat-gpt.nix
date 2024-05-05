{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    chat-gpt = makeDesktopItem {
      name = "Chat GPT";
      desktopName = "Chat GPT";
      genericName = "Chat GPT";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://chatgpt.com"'';
      icon = "ChatGPT";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "InstantMessaging"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [chat-gpt];
}
