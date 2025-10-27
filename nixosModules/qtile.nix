{ lib, pkgs, inputs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.qtile = {
      enable = true;
      extraPackages = pythonPkgs: with pkgs; [
        wtype
        grim
        slurp
        wl-clipboard
        pythonPkgs.qtile-extras
      ];
    };
  };

  # https://github.com/NixOS/nixpkgs/pull/297434#issuecomment-2348783988
  # systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";

  # From https://wiki.archlinux.org/title/Sway#Manage_Sway-specific_daemons_with_systemd`
  systemd.user.targets.qtile-session = {
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  environment.systemPackages = with pkgs; [ kanshi wl-clipboard alacritty ];

  # From https://wiki.archlinux.org/title/Kanshi#Manage_kanshi_with_systemd
  systemd.user.services = {
    libinput-gestures =
      let
        conffile = pkgs.writeText "libinput-gestures-conf" ''
          # Browser forwards and backwards
          gesture swipe left  wtype -M alt -k right
          gesture swipe right wtype -M alt -k left
        '';
      in
      {
        wantedBy = [ "qtile-session.target" ];
        path = [ pkgs.wtype ];
        serviceConfig.ExecStart = "${lib.getExe pkgs.libinput-gestures} -c ${conffile}";
      };
    # kanshi = {
    #   wantedBy = [ "qtile-session.target" ];
    #   serviceConfig.ExecStart = lib.getExe pkgs.kanshi;
    # };
  };

  # services.displayManager.ly.enable = true;
  security.polkit.enable = true;

  services.libinput = {
    enable = true;
    # not used by wayland?
    # touchpad = {
    #   naturalScrolling = true;
    #   disableWhileTyping = true;
    # };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };
  # environment.sessionVariables.XDG_CURRENT_DESKTOP = "sway";
  services.gvfs.enable = true; # file manager support for android phone
  programs.dconf.enable = true; # gnome theming thing (used for gtk theming)
  services.speechd.enable = false; # Enabled by default, but don't need it
}
