{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };

    windowManager.qtile.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
  services.gvfs.enable = true; # file manager support for android phone
  programs.dconf.enable = true; # gnome theming thing (used for gtk theming)
}
