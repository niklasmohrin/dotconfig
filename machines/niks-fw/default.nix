{ inputs, config, nixosModules, pkgs, username, ... }:
let
  inherit (pkgs) lib;
in
{
  system.stateVersion = "23.05";

  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series

    nixosModules.acpid-brightness
    nixosModules.audio
    nixosModules.clamav
    # nixosModules.framework-amd-ai-300
    nixosModules.desktop
    nixosModules.dev-tools
    nixosModules.office
    nixosModules.virtualisation
  ];

  # Don't need it
  hardware.framework.enableKmod = false;

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

  networking = {
    hostName = "niks-fw";
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
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
    };
    extraOptions = ''
      keep-outputs = true  # Do not garbage-collect build time-only dependencies (e.g. clang)
    '';

    registry.nixpkgs.flake = inputs.nixpkgs;
    registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
  };

  programs.nh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  services.xserver = {
    # dpi = 200;
    monitorSection = "DisplaySize 285 190";
    # deviceSection = ''
    #   Option "VariableRefresh" "true"
    # '';
    xkb = {
      layout = "us";
      # variant = "nodeadkeys";
    };
  };
  console.useXkbConfig = true;
  environment.variables = {
    # GDK_SCALE = "2";
    # GDK_DPI_SCALE = "0.5";
    # _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # QT_ENABLE_HIGHDPI_SCALING = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  environment.systemPackages = with pkgs; [ vim nvtopPackages.amd ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.steam.enable = true;

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "steam" "steam-unwrapped" "steam-original" "steam-run" ];
  };
}
