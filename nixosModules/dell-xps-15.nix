{ config, pkgs, nixosModules, ... }:
let
  inherit (pkgs) lib;
in
{
  imports = [ nixosModules.acpid-brightness ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem pkg.meta.license.shortName [ "CUDA EULA" "CUDA TOOLKIT" ] ||
      builtins.elem (lib.getName pkg) [ "nvidia-settings" "nvidia-x11" "steam" "steam-unwrapped" "steam-original" "steam-run" ];
  };

  environment.systemPackages = with pkgs; [
    powertop
    nvtopPackages.nvidia
    config.boot.kernelPackages.perf
  ];
}
