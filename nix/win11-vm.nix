# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import (builtins.fetchGit {
        url = "https://github.com/mrzenc/vgpu4nixos.git";
        # Pin to specific commit (example value)
        # rev = "b6ddaeb51b1575c6c8ec05b117c3a8bfa3539e92";
      }) { guest = false; })
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [ "kvmfr" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];

  boot.extraModprobeConfig = ''
    options nvidia vup_swrlwar=1
    options kvmfr  static_size_mb=32
  '';

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.extraHosts = "
    127.0.0.1 www.youtube.com
    127.0.0.1 www.reddit.com
    127.0.0.1 www.linkedin.com
    127.0.0.1 www.instagram.com
    127.0.0.1 news.ycombinator.com
    127.0.0.1 xcancel.com
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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  # :(
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

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
    ffmpeg
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
    ocaml
    rustc
    xclip
    usbutils
    pciutils
    unzip
    zip
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
    wolfram-engine
    ninja
    openscad
    typst
    racket
    obs-studio
    w_scan2
    gnumake
    poppler_utils
    zathura
    cobang
    sunxi-tools
    zulu23
    aspell
    aspellDicts.en
    looking-glass-client
  ];

  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    windowManager.xmonad = {
      enable = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib_0_18_1
      ];
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia.vgpu.patcher = {
    enable = true;
    copyVGPUProfiles = {"1C02:0000" = "1B38:0";};
    profileOverrides = {
      "156" = {
        vramAllocation = 2048;
        heads = 1;
        display.width = 1920;
        display.height = 1080;
      };
    };
  };
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.vgpu_16_5;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.i2c.enable = true;

  # rtkit is optional but recommended
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  fonts.packages = with pkgs; [
    ibm-plex
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.mdevctl.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.verbatimConfig = ''
      cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom",
        "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
        "/dev/rtc","/dev/hpet", "/dev/vfio/vfio", "/dev/kvmfr0"
      ]
    '';
  };

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

  services.udev.packages = [ pkgs.dolphin-emu ];

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
