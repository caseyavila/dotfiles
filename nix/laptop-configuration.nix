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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "laptop"; # Define your hostname.
  networking.hostId = "a0daf0ef";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  services.libinput.touchpad.tappingDragLock = false;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.xserver = {
    enable = true;

    displayManager.lightdm.background = "#000000";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };

    autoRepeatDelay = 200;
    autoRepeatInterval = 25;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.casey = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim-full
    wget
    curl
    file
    htop
    git
    python3
    silver-searcher
    gcc
    firefox
    keepassxc
    qemu
    usbutils
    killall
    unzip
    nasm
    openconnect
    gdb
    go
    p7zip
    gnumake
    qpwgraph
    obs-studio
    ghc
    tmux
    jdk17
    nmap
    sage
    qemu
    valgrind
    pulseaudio
    playerctl
    maim
    picom
    pavucontrol
    brightnessctl
    blender
    xmobar
    rofi
    alacritty
    vlc
    mpv
    racket
    typst
    xlayoutdisplay
    alsa-utils
    maim
    zathura
    w_scan2
    dvb-apps
    ffmpeg
    networkmanagerapplet
    xclip
    gtkwave
    sunxi-tools
    xorg.xhost
    zellij
    clang
    clang-tools
    libllvm
    lldb
    gf
    sonobus
    nuspell
    hunspellDicts.en_US
    prismlauncher
    foliate
    pstree
    zoom-us
    wolfram-engine
    audacity
    zed-editor
    verilator
    claude-code
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    ibm-plex
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.usbmuxd.enable = true;

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  services.resolved.enable = true;

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  environment.etc.hosts.enable = false;

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
