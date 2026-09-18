{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

let
  configRepo = /home/niklas/dotconfig;
  enableWithFish = {
    enable = true;
    enableFishIntegration = true;
  };
in
{
  home.username = "niklas";
  home.homeDirectory = "/home/niklas";

  home.stateVersion = "23.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    kdePackages.ark
    pkgs-unstable.rofi
    keepassxc

    git-absorb
    btop
    tealdeer
    dust
    rsync
    zip
    unzip

    typst
    (texlive.combine {
      inherit (texlive)
        scheme-medium
        enumitem
        titling
        todonotes
        cleveref
        ;
    })
    ipe
    diffpdf
    kdePackages.okular
    zathura
    pdftk
    ghostscript

    nil
    nixpkgs-fmt
    stylua
    lua-language-server
    (pkgs-unstable.tree-sitter)
    nix-output-monitor
    nix-tree

    zotero
    super-productivity
  ];
  fonts.fontconfig.enable = true;
  home.file =
    let
      link = config.lib.file.mkOutOfStoreSymlink;
      linkedFiles = [
        ".config/alacritty"
        ".config/qtile"
        ".config/nvim"
        ".tmux.conf"
        ".config/latexmk"
        ".config/kanshi"
        ".config/niri"
        ".config/waybar"
      ];
      linkedFilesConfig = builtins.listToAttrs (
        map (name: {
          inherit name;
          value.source = link (configRepo + "/${name}");
        }) linkedFiles
      );
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
    RIPGREP_CONFIG_PATH = pkgs.writeText "ripgrep-config" ''
      --hidden
      -g
      !.git
    '';
  };

  programs.git = {
    enable = true;
    signing = {
      key = null; # Use key matching the commit author
      signByDefault = true;
    };
    ignores = [
      ".vim-rooter"
      ".direnv"
    ];

    settings.user.name = "Niklas Mohrin";
    settings.user.email = "dev@niklasmohrin.de";
    settings.init.defaultBranch = "main";
    settings.branch.sort = "-committerdate";
  };
  programs.gh.enable = true;
  programs.difftastic.enable = true;
  programs.difftastic.git.enable = true;

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
}
