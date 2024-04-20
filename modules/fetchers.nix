{ pkgs, ... }:
# From https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles/blob/main/nixos/info-fetchers.nix
{
  environment.systemPackages = with pkgs; [
    neofetch
    onefetch
    ipfetch
    cpufetch
    ramfetch
    starfetch
    octofetch
    htop
    bottom
    btop
    zfxtop
    kmon
    # vulkan-tools
    # opencl-info
    # clinfo
    # vdpauinfo
    # libva-utils
    nvtop
    dig
    speedtest-rs
  ];
}
