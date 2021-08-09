set -x PATH \
    /bin \
    /usr/local/sbin \
    /usr/local/bin \
    /usr/bin \
    $HOME/.cargo/bin \
    $HOME/go/bin \
    $HOME/.local/bin \
    $HOME/.config/yarn/global/node_modules/.bin \
    $HOME/CTF/tools/bin \
    $HOME/Uni/CompProg/toolbin \
    $HOME/.gem/ruby/2.7.0/bin \
    $HOME/.local/share/gem/ruby/3.0.0/bin \
    /usr/bin/site_perl \
    /usr/bin/vendor_perl \
    /usr/bin/core_perl

fish_vi_key_bindings
bind           \cf accept-autosuggestion
bind -M insert \cf accept-autosuggestion

set VISUAL nvim
set EDITOR nvim
set FZF_DEFAULT_COMMAND "rg --files --hidden --iglob '!.git/**'"
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANPAGER "nvim -c 'set ft=man' -"
set XDG_DATA_HOME "$HOME/.local/share"
export GPG_TTY=(tty)

abbr exa exa -lahF
alias vim nvim
alias dotfilecfg 'git --git-dir=/home/niklas/dotfiles/ --work-tree=/home/niklas'
abbr vimcfg "vim ~/.config/nvim/init.vim"
abbr fishcfg "vim ~/.config/fish/config.fish"
abbr xclip "xclip -sel clip"
abbr cc "g++ -std=c++17 -Wall -Wextra"
abbr open xdg-open
alias cal "cal -m"

set fish_greeting
starship init fish | source
zoxide init fish | source
