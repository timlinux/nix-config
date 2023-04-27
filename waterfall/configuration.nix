# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "waterfall"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "pt";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  ##
  ## Yubikey PAM support - see https://nixos.wiki/wiki/Yubikey
  ## 
  services.udev.packages = [ pkgs.yubikey-personalization ];

  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };
  # Make sure to first do pam_u2f in above url before enabling this section
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.yubico = {
     enable = true;
     debug = true;
     mode = "challenge-response";
     # Make sure you yubikey is configured first
     # next line sets it to require both pwd and yk
     # need to read more, doesnt work
     control = "required";
  };
  # Yubikey ends ...

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    description = "Tim Sutton";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
      firefox
      qgis
      git
      mc
      ncdu
      wget
      deja-dup
      inkscape
      drawio
      libreoffice-fresh
      flameshot
      logseq
      vscode
      hugo
      gimp
      # After unstalling do
      # systemctl --user enable syncthing
      # See also https://discourse.nixos.org/t/syncthing-systemd-user-service/11199
      syncthing
      synfigstudio
      kdenlive
      obs-studio
      qtcreator
      slack
      google-chrome
      nextcloud-client
      tdesktop
      paperwork
      gnome.gnome-software
      keepassxc
      gotop
      nethogs
      iftop
      blender
      gnome.gnome-terminal
      aspellDicts.uk 
      starship
      btop
      gnucash
      maple-mono-NF
      maple-mono-SC-NF
      nerdfonts
      citations
      emblem
      eyedropper
      gaphor
      #lorem
      solanum
      zap
      aspell
      aspellDicts.en
      aspellDicts.uk 
      aspellDicts.pt_PT

    ];

  };

  ##
  ## Nvidia related
  ##

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # My card is the Geforce 1030
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.nvidia.modesetting.enable = true;
  # Fix dispay issues on suspend resume
  hardware.nvidia.powerManagement.enable = true;  

  ##
  ## End of nvidia settings
  ##

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     neovim
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     python3
     libimobiledevice # Iphone support
     ifuse # optional, to mount using 'ifuse' for iPhone
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    allowSFTP = false; # Don't set this if you need sftp
    kbdInteractiveAuthentication = false;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ### 
  ### Additions by Tim (see also pkgs sections above)
  ###
  
  ### Fingerprint reader support
  ### See https://discourse.nixos.org/t/how-to-use-fingerprint-unlocking-how-to-set-up-fprintd-english/21901
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  # Works for thinkpad p14s
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090; 
  # If the vfs0090 Driver does not work, use the following driver
  #services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  ### Flakes support
      
  ### See https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  ### OBS Virtual Camera Support
  ### See also OBS packages installed further up
  boot.extraModulePackages = [
     config.boot.kernelPackages.v4l2loopback
  ];  

  ###
  ### Flatpack support
  ### see https://flatpak.org/setup/NixOS
  services.flatpak.enable = true;

  ##
  ## iPhone Support
  ## 
  services.usbmuxd.enable = true;


}
