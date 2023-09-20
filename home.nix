{ config, pkgs, ... }:

let
  configRepo = /home/niklas/dotconfig;
in {
  home.username = "niklas";
  home.homeDirectory = "/home/niklas";

  home.stateVersion = "23.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alacritty
    btop
    clang
    tree-sitter
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];
  fonts.fontconfig.enable = true;

  home.file = let
    link = config.lib.file.mkOutOfStoreSymlink;
    linkedFiles = [ ".config/alacritty" ".config/qtile" ".config/nvim" ".tmux.conf" ];
    linkedFilesConfig = builtins.listToAttrs (map (name: {
      inherit name;
      value.source = link (configRepo + "/${name}");
    }) linkedFiles);
  in {} // linkedFilesConfig;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    CARGO_TARGET_DIR = "$XDG_CACHE_HOME/cargo-target-dir";
    MANPAGER = "nvim +Man!";
  };

  programs.git = {
    enable = true;
    userName = "Niklas Mohrin";
    userEmail = "dev@niklasmohrin.de";

    # TODO: signing

    difftastic.enable = true;
  };

  programs.fish = {
    enable = true;
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
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
