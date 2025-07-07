{
  system ? builtins.currentSystem,
  pkgs,
  config,
  ...
}: {
  # Unstable defined in flake.nix and overlaid to be available here
  # noise suppression tool - creates a virtual mic
  # For context, read up about LADSPA plugins in linux
  # and see /run/current-system/sw/lib/ladspa/
  # which you will need to point software like OBS
  # You can try to scan the plugin with
  # nix-shell -p plugin-torture
  # plugin-torture -s -e -p /run/current-system/sw/lib/ladspa/libdeep_filter_ladspa.so
  # Though it crashes
  # Needs more research to see how to integrate it with google meet etc.
  environment.systemPackages = with pkgs; [
    deepfilternet
  ];
}
