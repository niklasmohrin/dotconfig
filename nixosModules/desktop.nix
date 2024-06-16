{
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

  services.gvfs.enable = true; # file manager support for android phone
  programs.dconf.enable = true; # gnome theming thing (used for gtk theming)
}
