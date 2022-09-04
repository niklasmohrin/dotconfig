set -x PATH \
    /bin \
    /usr/local/sbin \
    /usr/local/bin \
    /usr/bin \
    $HOME/.cargo/bin \
    $HOME/go/bin \
    $HOME/.local/bin \
    $HOME/.local/share/yarn/global/node_modules/.bin \
    $HOME/Uni/SoSe21/CompProg/toolbin \
    /usr/bin/site_perl \
    /usr/bin/vendor_perl \
    /usr/bin/core_perl

set -x VISUAL nvim
set -x EDITOR nvim
set -x MANPAGER "nvim +Man!"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x GPG_TTY (tty)

if status is-interactive
    fish_vi_key_bindings
    bind           \cf accept-autosuggestion
    bind -M insert \cf accept-autosuggestion
    starship init fish | source
    zoxide init fish | source

    alias dcfg 'git --git-dir=/home/niklas/dotfiles/ --work-tree=/home/niklas'

    abbr cal "cal -m"
    abbr cc "g++ -std=c++20 -Wall -Wextra"
    abbr exa exa -lahF
    abbr fishcfg "nvim ~/.config/fish/config.fish"
    abbr open xdg-open
    abbr qtilecfg "nvim ~/.config/qtile/config.py"
    abbr triple-monitor 'xrandr --output eDP-1 --auto --output DP-3 --primary --auto --right-of eDP-1 --output DP-1 --auto --right-of DP-3'
    abbr vim nvim
    abbr xclip "xclip -sel clip"

    abbr g "git"
    abbr ga "git add"
    abbr gap "git add -p"
    abbr gc "git commit"
    abbr gca "git commit --amend"
    abbr gcan "git commit --amend --no-edit"
    abbr gd "git diff"
    abbr gds "git diff --staged"
    abbr gff "git pull --ff-only"
    abbr gffu "git pull --ff-only upstream (git branch --show-current)"
    abbr gl "git log"
    abbr gp "git push"
    abbr gr "git rebase"
    abbr gri "git rebase --interactive --autosquash"
    abbr gs "git status"
    abbr gsh "git show"
    abbr gsw "git switch"
end

set fish_greeting
