{ lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/pull/297434#issuecomment-2348783988
  # systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";

  # From https://wiki.archlinux.org/title/Sway#Manage_Sway-specific_daemons_with_systemd`
  systemd.user.targets.qtile-session = {
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];

  };
  programs.i3lock.enable = true;

  # environment.systemPackages = [ pkgs.kanshi ];
  # From https://wiki.archlinux.org/title/Kanshi#Manage_kanshi_with_systemd
  systemd.user.services.kanshi = {
    wantedBy = [ "qtile-session.target" ];
    serviceConfig.ExecStart = lib.getExe pkgs.kanshi;
  };

  services.displayManager.ly.enable = true;
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
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "*"; # use first found portal implementation for everything (silence warning)
  };
  services.gvfs.enable = true; # file manager support for android phone
  programs.dconf.enable = true; # gnome theming thing (used for gtk theming)
  services.speechd.enable = false; # Enabled by default, but don't need it
}
