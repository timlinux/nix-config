# See https://github.com/tadfisher/android-nixpkgs#ad-hoc
{ stdenv, config, pkgs, ... }:

let
  android-nixpkgs = import
	(builtins.fetchTarball https://github.com/tadfisher/android-nixpkgs/tarball/stable) 
	# reuse the current configuration
	{
	    # Default; can also choose "beta", "preview", or "canary".
	    channel = "stable";
	};
in
android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
  cmdline-tools-latest
  build-tools-31-0-0
  platform-tools
  platforms-android-31
  emulator
])
