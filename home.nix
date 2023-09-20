{ config, pkgs, ... }:

{
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
      value.source = ./. + "/${name}";
    }) linkedFiles);
  in {} // linkedFilesConfig;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
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
    shellAbbrs = { vim = "nvim"; };
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
