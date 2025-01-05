{ config, pkgs, ... }:
let
  inherit (pkgs) lib;
in
{
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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

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

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem pkg.meta.license.shortName [ "CUDA EULA" "CUDA TOOLKIT" ] ||
      builtins.elem (lib.getName pkg) [ "nvidia-settings" "nvidia-x11" "steam" "steam-original" "steam-run" ];
  };

  environment.systemPackages = with pkgs; [
    powertop
    nvtopPackages.nvidia
    config.boot.kernelPackages.perf
  ];
}
