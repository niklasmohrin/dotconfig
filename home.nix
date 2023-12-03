{ config, pkgs, pkgs-unstable, lib, ... }:

let
  inherit (lib.meta) hiPrio;
  configRepo = /home/niklas/dotconfig;
  enableWithFish = { enable = true; enableFishIntegration = true; };
in
{
  home.username = "niklas";
  home.homeDirectory = "/home/niklas";

  home.stateVersion = "23.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];
  home.packages = with pkgs; [
    alacritty
    arandr
    autorandr
    (nerdfonts.override { fonts = [ "CascadiaCode" "Ubuntu" ]; })
    rofi
    xclip
    i3lock

    libinput-gestures
    wmctrl
    playerctl

    cinnamon.nemo
    libsForQt5.ark
    firefox
    ungoogled-chromium
    thunderbird
    keepassxc
    libreoffice
    pkgs-unstable.discord
    spotify
    telegram-desktop
    signal-desktop
    vlc
    obs-studio
    gnome.eog
    gimp

    pinentry-curses

    btop
    tealdeer
    du-dust
    rsync

    clang
    (hiPrio gcc)
    rustup

    typst
    typst-lsp
    typst-fmt
    (texlive.combine {
      inherit (texlive) scheme-medium enumitem titling todonotes cleveref;
    })
    okular
    zathura

    nil
    nixpkgs-fmt
    stylua
    tree-sitter
  ];
  fonts.fontconfig.enable = true;

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
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  home.file =
    let
      link = config.lib.file.mkOutOfStoreSymlink;
      linkedFiles = [ ".config/alacritty" ".config/qtile" ".config/nvim" ".tmux.conf" ".config/latexmk" ];
      linkedFilesConfig = builtins.listToAttrs (map
        (name: {
          inherit name;
          value.source = link (configRepo + "/${name}");
        })
        linkedFiles);
    in
    { } // linkedFilesConfig;

  xdg.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    CARGO_TARGET_DIR = "${config.xdg.cacheHome}/cargo-target-dir";
    MANPAGER = "nvim +Man!";
  };

  services.picom = {
    enable = true;
    vSync = true;
  };

  # Fix tray.target not being present (https://github.com/nix-community/home-manager/issues/2064)
  systemd.user.targets.tray.Unit = {
    Description = "Home Manager System Tray";
    Requires = [ "graphical-session-pre.target" ];
  };
  services.pasystray.enable = true;
  services.dunst.enable = true;
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = enableWithFish // {
    pinentryFlavor = "curses";
  };

  programs.git = {
    enable = true;
    userName = "Niklas Mohrin";
    userEmail = "dev@niklasmohrin.de";
    signing = {
      key = null; # Use key matching the commit author
      signByDefault = true;
    };
    ignores = [ ".vim-rooter" ".direnv" ];
    difftastic.enable = true;
  };
  programs.gh.enable = true;

  programs.fish = {
    enable = true;
    functions = {
      take.body = "mkdir -p $argv[1]; and cd $argv[1]";
    };
    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings
      bind           \cf accept-autosuggestion
      bind -M insert \cf accept-autosuggestion
    '';
    shellAbbrs = {
      vim = "nvim";
      cal = "cal -m";
      open = "xdg-open";
      xclip = "xclip -sel clip";
      g = "git";
      ga = "git add";
      gap = "git add -p";
      gc = "git commit";
      gd = "git diff";
      gds = "git diff --staged";
      gff = "git pull --ff-only";
      gffu = "git pull --ff-only upstream (git branch --show-current)";
      gl = "git log";
      gp = "git push";
      gr = "git rebase";
      gri = "git rebase --interactive --autosquash";
      gs = "git status";
      gsh = "git show";
      gsw = "git switch";
    };
  };
  programs.nix-index = enableWithFish;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.zoxide = enableWithFish;

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  services.flameshot.enable = true;

  systemd.user.services.backup = {
    Unit.Description = "Backs up files";
    Service = {
      ExecStart = "${pkgs.rsync}/bin/rsync %h/Sync -CERrltm pi:Sync";
      Environment = "PATH=${lib.makeBinPath [ pkgs.openssh ]}";
    };
  };
  systemd.user.paths.backup = {
    Unit.Description = "Checks if paths that are currently being backed up have changed";
    Path.PathChanged = "%h/Sync";
    Install.WantedBy = [ "default.target" ];
  };
}
