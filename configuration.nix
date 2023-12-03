{ config, pkgs, username, ... }:

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
      trusted-public-keys = [ "lean4.cachix.org-1:mawtxSxcaiWE24xCXXgh3qnvlTkyU7evRRnGeAhD4Wk=" ];
    };
    extraOptions = ''
      keep-outputs = true  # Do not garbage-collect build time-only dependencies (e.g. clang)
    '';
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "cudatoolkit"
    "nvidia-x11"
    "nvidia-settings"
    "steam"
    "steam-original"
    "steam-run"
  ];

  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "scanner" "lp" "libvirtd" ];
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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true; # Let audio services acquire realtime scheduling priority

  services.acpid = {
    enable = true;
    handlers =
      let
        event-to-action = {
          "video/brightnessup" = "${pkgs.brightnessctl}/bin/brightnessctl set +10%";
          "video/brightnessdown" = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
        };
      in
      builtins.listToAttrs (map
        (event: {
          name = builtins.replaceStrings [ "/" ] [ "-" ] event;
          value = {
            inherit event;
            action = event-to-action.${event};
          };
        })
        (builtins.attrNames event-to-action));
  };

  environment.systemPackages = with pkgs; [
    bat
    brightnessctl
    clamav
    curl
    fd
    file
    fzf
    git
    htop
    input-utils
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
    virt-manager
    wget
  ];

  services.clamav.updater = { enable = true; interval = "daily"; };

  # virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  services.gvfs.enable = true; # file manager support for android phone
  programs.dconf.enable = true; # gnome theming thing (used for gtk theming) + virt-manager requires dconf to remember settings

  services.avahi.enable = true; # service discovery (for example printers)
  services.avahi.nssmdns = true; # resolving xyz.local
  services.avahi.openFirewall = true;
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint foomatic-db ];
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  programs.steam.enable = true;
}
