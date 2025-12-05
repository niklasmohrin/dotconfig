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
    wdisplays
    wlr-randr
    wl-clipboard

    nerd-fonts.caskaydia-cove
    nerd-fonts.ubuntu
    pkgs-unstable.rofi
    git-absorb

    playerctl

    nemo
    kdePackages.ark
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
    eog
    gimp3

    btop
    tealdeer
    du-dust
    rsync
    zip
    unzip

    clang
    (hiPrio gcc)
    rustup

    typst
    typst-fmt
    (texlive.combine {
      inherit (texlive) scheme-medium enumitem titling todonotes cleveref;
    })
    ipe
    kdePackages.okular
    zathura
    pdftk
    ghostscript
    pkgs-unstable.musescore

    nil
    nixpkgs-fmt
    stylua
    lua-language-server
    (pkgs-unstable.tree-sitter)
    nix-output-monitor

    zotero
    logseq
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
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  home.file =
    let
      link = config.lib.file.mkOutOfStoreSymlink;
      linkedFiles = [ ".config/alacritty" ".config/qtile" ".config/nvim" ".tmux.conf" ".config/latexmk" ".config/kanshi" ".config/niri" ".config/waybar" ];
      linkedFilesConfig = builtins.listToAttrs (map
        (name: {
          inherit name;
          value.source = link (configRepo + "/${name}");
        })
        linkedFiles);
      otherFilesConfig = {
        ".config/gdb/gdbinit".text = ''
          set history save on
          set history size 1024
          set history filename ${config.xdg.cacheHome}/gdb_history
        '';
        ".config/rofi/config.rasi".text = ''
          configuration {
              modi: "combi";
              font: "Ubuntu Regular 11";
              show-icons: true;
              terminal: "alacritty";
              ssh-command: "{terminal} -e ssh {host}";
              combi-modi: "drun,ssh,window";
          }
        '';
        ".config/hypr/hyprlock.conf".text = ''
          source = ${pkgs.hyprlock}/share/hypr/hyprlock.conf
          auth {
              fingerprint {
                  enabled = true
                  ready_message = Scan fingerprint to unlock
                  present_message = Scanning...
                  retry_delay = 250 # in milliseconds
              }
          }
        '';
        ".config/hypr/hypridle.conf".text = ''
          general {
            lock_cmd = pidof hyprlock || hyprlock
            before_sleep_cmd = loginctl lock-session
          }
        '';
      };
    in
    linkedFilesConfig // otherFilesConfig;

  xdg.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    CARGO_TARGET_DIR = "${config.xdg.cacheHome}/cargo-target-dir";
    MANPAGER = "nvim +Man!";
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
  services.flameshot.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = enableWithFish // {
    pinentry.package = pkgs.pinentry-curses;
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
    extraConfig = {
      "init"."defaultBranch" = "main";
      "branch"."sort" = "-committerdate";
    };

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
      for mode in (bind --list-modes); bind -M $mode ctrl-c cancel-commandline; end
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
      gcp = "git cherry-pick";
      gcpc = "git cherry-pick --continue";
      gcpa = "git cherry-pick --abort";
    };
  };
  programs.nix-index = enableWithFish;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.zoxide = enableWithFish;
  programs.eza = enableWithFish;

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
