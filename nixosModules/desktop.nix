{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };
  programs.i3lock.enable = true;

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
    config.common.default = "*"; # use first found portal implementation for everything (silence warning)
  };
  services.gvfs.enable = true; # file manager support for android phone
  programs.dconf.enable = true; # gnome theming thing (used for gtk theming)
  services.speechd.enable = false; # Enabled by default, but don't need it
}
