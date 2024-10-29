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

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.extraHosts = "
    127.0.0.1 www.reddit.com
    127.0.0.1 www.youtube.com
    127.0.0.1 www.linkedin.com
    127.0.0.1 www.instagram.com
    127.0.0.1 news.ycombinator.com
    127.0.0.1 play.typeracer.com
  ";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.casey = {
    isNormalUser = true;
    description = "casey";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # :(
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  #nixpkgs.config.cudaSupport = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim_configurable
    wget
    file
    git
    firefox
    silver-searcher
    gcc
    tmux
    gdb
    rofi
    alacritty
    keepassxc
    killall
    htop
    (mpv.unwrapped.override { cddaSupport = true; })
    pulseaudio
    alsa-utils
    openconnect
    pavucontrol
    playerctl
    maim
    picom
    python3
    qemu
    blender
    go
    ghc
    ocaml
    rustc
    xclip
    usbutils
    unzip
    inkscape
    valgrind
    nmap
    appimage-run
    qpwgraph
    ddcutil
    xmobar
    dolphin-emu
    cemu-ti
    cmake
    discord
    wolfram-engine
    ghidra
    ninja
    openscad
    clang
    racket
    lean4
    agda
    llvm_18
  ];

  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };

    displayManager.lightdm.background = "#000000";

    autoRepeatDelay = 250;
    autoRepeatInterval = 20;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.libinput = {
    enable = true;

    # disabling mouse acceleration
    mouse = {
      accelProfile = "flat";
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.i2c.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  fonts.packages = with pkgs; [
    ibm-plex
    noto-fonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  services.resolved.enable = true;

  services.udev.packages = [ pkgs.dolphinEmu ];

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
