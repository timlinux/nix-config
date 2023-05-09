{ pkgs, ... }:
# Wacom tablet support
# Nixos docs are a bit scant on wacom tablets
# So you may also want to read here:
# https://wiki.archlinux.org/title/Graphics_tablet
# One thing to note: In the above article they refer
# to devices by name, but I had problems doing that
# so use the device number instead. You can do
# xsetwacom list --devices
# to get a list of devices.
{
  environment.interactiveShellInit = ''
    # Not sure if this is the best place to do it, 
    # but set up the keybindings for the keys on the tablet
    # 25 = pad on Intuos
    xsetwacom set 25 Button 1 "key +ctrl z -ctrl"
    # simplify geometry in inkscape    
    xsetwacom set 25 Button 2 "key +ctrl l -ctrl"    
  '';

  # Wacom tablet support
  # Depending on your tablet model you may also need to connect it via bluetooth
  services.xserver.wacom.enable = true;

  environment.systemPackages = with pkgs; [
     xf86_input_wacom
     xsetwacom
  ];
}


