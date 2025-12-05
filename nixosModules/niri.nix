{ pkgs, lib, ... }:
{
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  # services.displayManager.ly.enable = true;
  # # https://codeberg.org/fairyglade/ly/issues/706#issuecomment-5460939
  # systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
  security.polkit.enable = true;

  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [ kanshi wl-clipboard xwayland-satellite swaybg alacritty brightnessctl ];

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = false;
  security.pam.services.ly.fprintAuth = false;

  programs.waybar.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-gnome ];
    # https://cashmere.rs/blog/20250612002456-how_to_fix_screensharing_for_niri_wm_under_nixos.html
    config.niri = {
      default = [ "gtk" "gnome" ];
    };
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "niri";
  };


  systemd.user.services =
    let
      make = name: {
        ${name} = {
          partOf = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          requisite = [ "graphical-session.target" ];
          wantedBy = [ "niri.service" ];
          serviceConfig.ExecStart = lib.getExe pkgs.${name};
        };
      };
    in
    (make "kanshi") // {
      waybar.path = with pkgs; [ alacritty brightnessctl htop networkmanager ];
    };
}
