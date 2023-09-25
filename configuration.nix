{ config, pkgs, ... }:

{
  system.stateVersion = "23.05";

  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      secrets."/crypto_keyfile.bin" = null;
      luks.devices."luks-9b03d16c-8a3d-460a-a443-5ffb97dc2bf4" = {
        device = "/dev/disk/by-uuid/9b03d16c-8a3d-460a-a443-5ffb97dc2bf4";
        keyFile = "/crypto_keyfile.bin";
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  networking = {
    hostName = "niks-xps";
    networkmanager.enable = true;
  };
  services.openvpn.servers.homeVPN = {
    config = '' config /home/niklas/Documents/NiklasXPS.ovpn '';
    autoStart = false;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
      trusted-substituters = [ "https://lean4.cachix.org/" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "lean4.cachix.org-1:mawtxSxcaiWE24xCXXgh3qnvlTkyU7evRRnGeAhD4Wk=" ];
    };
    extraOptions = ''
      keep-outputs = true  # Do not garbage-collect build time-only dependencies (e.g. clang)
    '';
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "cudatoolkit"
    "nvidia-x11"
    "nvidia-settings"
  ];

  users.users.niklas = {
    isNormalUser = true;
    description = "niklas";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  services.xserver = {
    enable = true;
    layout = "de";
    xkbVariant = "nodeadkeys";

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };

    displayManager.sddm.enable = true;
    windowManager.qtile.enable = true;
  };
  console.keyMap = "de-latin1-nodeadkeys";
  # systemd.services.libinput-gestures = {
  #   enable = true;
  #   description = "Start libinput-gestures";
  #   after = [ "graphical.target" ];
  #   wantedBy = [ "graphical.target" ];
  #   environment.DISPLAY = ":0";
  #
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
  #   };
  # };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true; # Let audio services acquire realtime scheduling priority

  environment.systemPackages = with pkgs; [
    bat
    curl
    fd
    file
    fzf
    git
    htop
    lshw
    neovim
    nvtop
    pciutils
    powertop
    psmisc
    ripgrep
    tmux
    usbutils
    vim
    wget
  ];

  virtualisation.docker.enable = true;
  services.gvfs.enable = true; # file manager support for android phone
  services.blueman.enable = true; # bluetooth
  programs.dconf.enable = true; # gnome theming thing (used for gtk theming)
}
