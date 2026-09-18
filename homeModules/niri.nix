{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  inherit (lib.meta) hiPrio;
in
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];

  home.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.ubuntu

    wdisplays
    wlr-randr
    wl-clipboard

    playerctl
    nemo
    firefox
    ungoogled-chromium
    thunderbird
    libreoffice

    pkgs-unstable.discord
    spotify
    telegram-desktop
    signal-desktop
    vlc
    obs-studio
    eog
    gimp3

    clang
    (hiPrio gcc)
    rustup

    pkgs-unstable.musescore
    qbittorrent
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
    gtk4.theme = config.gtk.theme;

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig.Settings = ''
      gtk-application-prefer-dark-theme=1
    '';

    gtk4.extraConfig.Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };
  home.sessionVariables.GTK_THEME = "palenight";
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # Fix tray.target not being present (https://github.com/nix-community/home-manager/issues/2064)
  systemd.user.targets.tray.Unit = {
    Description = "Home Manager System Tray";
    Requires = [ "graphical-session-pre.target" ];
  };
  # services.pasystray.enable = true;
  services.dunst.enable = true;
  xsession.preferStatusNotifierItems = true;
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
  # services.flameshot.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    pinentry.package = pkgs.pinentry-curses;
  };

}
