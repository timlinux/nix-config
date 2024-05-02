{
  config,
  pkgs,
  lib,
  hostname,
  desktop,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  isLima = builtins.substring 0 5 hostname == "lima-";
  isWorkstation =
    if (desktop != null)
    then true
    else false;
  isTimMachine =
    if (hostname == "crest" || hostname == "waterfall" || hostname == "valley")
    then true
    else false;
in {
  config = {
    programs.fish = {
      enable = true;
      shellAliases = {
        banner = lib.mkIf isLinux "${pkgs.figlet}/bin/figlet";
        banner-color = lib.mkIf isLinux "${pkgs.figlet}/bin/figlet $argv | ${pkgs.dotacat}/bin/dotacat";
        brg = "${pkgs.bat-extras.batgrep}/bin/batgrep";
        cat = "${pkgs.bat}/bin/bat --paging=never";
        dadjoke = ''${pkgs.curlMinimal}/bin/curl --header "Accept: text/plain" https://icanhazdadjoke.com/'';
        dmesg = "${pkgs.util-linux}/bin/dmesg --human --color=always";
        neofetch = "${pkgs.fastfetch}/bin/fastfetch";
        glow = "${pkgs.glow}/bin/glow --pager";
        hr = ''${pkgs.hr}/bin/hr "─━"'';
        htop = "${pkgs.bottom}/bin/btm --basic --tree --hide_table_gap --dot_marker --mem_as_value";
        ip = "${pkgs.iproute2}/bin/ip --color --brief";
        less = "${pkgs.bat}/bin/bat";
        lolcat = "${pkgs.dotacat}/bin/dotacat";
        make-lima-builder = "lima-create builder";
        make-lima-default = "lima-create default";
        moon = "${pkgs.curlMinimal}/bin/curl -s wttr.in/Moon";
        more = "${pkgs.bat}/bin/bat";
        checkip = "${pkgs.curlMinimal}/bin/curl -s ifconfig.me/ip";
        parrot = "${pkgs.terminal-parrot}/bin/terminal-parrot -delay 50 -loops 7";
        ruler = ''${pkgs.hr}/bin/hr "╭─³⁴⁵⁶⁷⁸─╮"'';
        screenfetch = "${pkgs.fastfetch}/bin/fastfetch";
        speedtest = "${pkgs.speedtest-go}/bin/speedtest-go";
        store-path = "${pkgs.coreutils-full}/bin/readlink (${pkgs.which}/bin/which $argv)";
        top = "${pkgs.bottom}/bin/btm --basic --tree --hide_table_gap --dot_marker --mem_as_value";
        tree = "${pkgs.eza}/bin/eza --tree";
        wormhole = "${pkgs.wormhole-william}/bin/wormhole-william";
        weather = "${pkgs.wthrr}/bin/wthrr auto -u f,24h,c,mph -f d,w";
        weather-home = "${pkgs.wthrr}/bin/wthrr basingstoke -u f,24h,c,mph -f d,w";

        ls = "eza --icons=always";
        find = "fd";
        l = "eza -alh --icons=always";
        ll = "eza -l --icons=always";
        psql = "pgcli";
        open = "xdg-open";
        ping = "gping";
        du = "dust";
        icat = "kitty +kitten icat";
        # See https://github.com/kovidgoyal/kitty/issues/713#issuecomment-750704294
        ssh = "kitty +kitten ssh";
      };
    };
  };
}
