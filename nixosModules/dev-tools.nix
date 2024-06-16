{ config, pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    pkgs-unstable.neovim

    bat
    curl
    fd
    file
    git
    htop
    psmisc
    ripgrep
    tmux
    wget
  ];
}
