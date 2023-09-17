set -x PATH \
    /bin \
    /usr/local/sbin \
    /usr/local/bin \
    /usr/bin \
    $HOME/.cargo/bin \
    $HOME/go/bin \
    $HOME/.local/bin \
    $HOME/.local/share/yarn/global/node_modules/.bin \
    $HOME/Dev/cp/toolbin \
    /usr/bin/site_perl \
    /usr/bin/vendor_perl \
    /usr/bin/core_perl

set -x VISUAL nvim
set -x EDITOR nvim
set -x MANPAGER "nvim +Man!"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x GPG_TTY (tty)

set -x CARGO_TARGET_DIR "$HOME/.cache/cargo-target-dir/"

if status is-interactive
    fish_vi_key_bindings
    bind           \cf accept-autosuggestion
    bind -M insert \cf accept-autosuggestion
    starship init fish | source
    zoxide init fish | source

    alias dcfg 'git --git-dir=/home/niklas/dotfiles/ --work-tree=/home/niklas'

    abbr cal "cal -m"
    abbr cc "g++ -std=c++20 -Wall -Wextra"
    abbr l eza -lahF
    abbr fishcfg "nvim ~/.config/fish/config.fish"
    abbr open xdg-open
    abbr qtilecfg "nvim ~/.config/qtile/config.py"
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

    # Kanagawa Fish shell theme
    set -l foreground DCD7BA
    set -l selection 2D4F67
    set -l comment 727169
    set -l red C34043
    set -l orange FF9E64
    set -l yellow C0A36E
    set -l green 76946A
    set -l purple 957FB8
    set -l cyan 7AA89F
    set -l pink D27E99

    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment

    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
end

set fish_greeting
