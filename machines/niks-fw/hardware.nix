{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/075480b4-d21b-4ca6-af99-6d240063a678";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-0173adb7-d300-48a2-81ed-69599b5853bc".device = "/dev/disk/by-uuid/0173adb7-d300-48a2-81ed-69599b5853bc";

  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/F7E0-09F8";
  #     fsType = "vfat";
  #   };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ed3af4a2-3d5a-40fb-93b0-68b633745f3a"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20f0u5u1u3.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp59s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
