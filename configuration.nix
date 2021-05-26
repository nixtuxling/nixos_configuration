# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Systemd-boot:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking options:
  networking = {
    hostName = "madelyns-craptop";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    enableIPv6 = false;
    firewall.enable = true;
    firewall.allowPing = false;
    networkmanager.enable = true;
    enableB43Firmware = true;
  };
  
  # Time zone:
  time.timeZone = "America/Chicago";
  
  # Locales:
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Docker:
  virtualisation.docker = {
    enable = true;
  };

  # Enable X11:
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
    wacom.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
  
  # Enable CUPS:
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr ];
    defaultShared = false;
  };

  # Enable sound:
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  
  # Enable pulseaudio:
  hardware.pulseaudio.enable = true;
  
  # Users:
  users.users.madelyn = {
    home = "/home/madelyn";
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "storage" "power" "video" "networkmanager" "docker" ];
  };

  # Allow Unfree:
  nixpkgs.config.allowUnfree = true;
  
  # Auto upgrade:
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };
  
  # Auto optimize:
  nix.autoOptimiseStore = true;
    
  # System packages:
  environment.systemPackages = with pkgs; [
    # Fonts:
    noto-fonts-cjk
    # Console:
    man
    nano
    file
    lsof
    bash
    curl
    wget
    gnupg
    unzip
    unrar
    p7zip
    man-db
    neofetch
    youtube-dl
    xorg.xkill
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    # Development:
    git
    jdk
    zeal
    maven
    gradle
    groovy
    kdevelop
    vscodium
    netbeans
    smartgithg
    jetbrains.pycharm-community
    # Internet:
    firefox
    tdesktop
    qbittorrent
    konversation
    # Games:
    steam
    lutris
    discord
    # Graphics:
    krita
    gwenview
    spectacle
    kcolorchooser
    # Office:
    okular
    qownnotes
    libreoffice
    thunderbird
    # Education:
    anki
    tagainijisho
    # Multimedia:
    vlc
    cantata
    obs-studio
    pulseeffects-legacy
    # Accesories:
    ark
    kate
    kcalc
    keepassxc
    # System:
    docker
    konsole
    dolphin
    thermald
    ksysguard
    ksystemlog
    # Security:
    clamav
    openvpn
    bleachbit
    chkrootkit 
  ];

  # Clamav:
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    updater.interval = "hourly";
  };

  # Power:
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    scsiLinkPolicy = "min_power";
  };
  
  # Thermald:
  services.thermald = {
    enable = true;
  };
  
  # GNUPG:
  programs.gnupg.agent = {
    enable = true;
  };


  system.stateVersion = "20.09";

}

