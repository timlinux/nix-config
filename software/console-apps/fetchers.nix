{pkgs, ...}:
# From https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles/blob/main/nixos/info-fetchers.nix
# And wimpysworld/nix-config/home-manager/default.nix
{
  environment.systemPackages = with pkgs; [
    bandwhich # Modern Unix `iftop`
    bmon # Modern Unix `iftop`
    chafa # Terminal image viewer
    cpufetch # Terminal CPU info
    dconf2nix # Nix code from Dconf files
    difftastic # Modern Unix `diff`
    dogdns # Modern Unix `dig`
    dotacat # Modern Unix lolcat
    dua # Modern Unix `du`
    duf # Modern Unix `df`
    du-dust # Modern Unix `du`
    entr # Modern Unix `watch`
    # See home/home-config/console-apps/fastfetch/ for custom fastfetch
    #fastfetch # Modern Unix system info
    fd # Modern Unix `find`
    gping # Modern Unix `ping`
    hr # Terminal horizontal rule
    hyperfine # Terminal benchmarking
    iperf3 # Terminal network benchmarking
    mtr # Modern Unix `traceroute`
    neo-cowsay # Terminal ASCII cows
    nyancat # Terminal rainbow spewing feline
    onefetch # Terminal git project info
    procs # Modern Unix `ps`
    speedtest-go # Terminal speedtest.net
    terminal-parrot # Terminal ASCII parrot
    tldr # Modern Unix `man`
    tokei # Modern Unix `wc` for code
    wthrr # Modern Unix weather
    wormhole-william # Terminal file transfer
    figlet # Terminal ASCII banners
    iw # Terminal WiFi info
    lurk # Modern Unix `strace`
    ramfetch # Terminal system info
    usbutils # Terminal USB info
    wavemon # Terminal WiFi monitor
    writedisk # Modern Unix `dd`
    neofetch # system info
    onefetch # git info
    ipfetch # ip info
    cpufetch # cpu info
    ramfetch # ram info
    starfetch # star count
    octofetch # github info
    htop # system monitor
    bottom # system monitor - invoke with `btm`
    btop # system monitor
    zfxtop # zfs monitor
    kmon # kernel monitor
    # vulkan-tools
    # opencl-info
    # clinfo
    # vdpauinfo
    # libva-utils
    #nvtop # nvidia gpu monitor ## XXX Disabled to avoid pulling in cuda which takes ages to build
    dig # dns lookup
    speedtest-rs # speedtest
  ];
}
