{ inputs, config, nixosModules, pkgs, username, ... }:
let
  inherit (pkgs) lib;
in
{
  system.stateVersion = "23.05";

  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia

    nixosModules.audio
    nixosModules.clamav
    nixosModules.dell-xps-15
    nixosModules.desktop
    nixosModules.dev-tools
    nixosModules.office
    nixosModules.virtualisation
  ];

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
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
      trusted-substituters = [ "https://lean4.cachix.org/" ];
      trusted-public-keys = [ "lean4.cachix.org-1:mawtxSxcaiWE24xCXXgh3qnvlTkyU7evRRnGeAhD4Wk=" ];
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

  console.keyMap = "de-latin1-nodeadkeys";

  environment.systemPackages = [ pkgs.vim ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.steam.enable = true;
}
