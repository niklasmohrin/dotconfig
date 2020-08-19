set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/go/bin
set VISUAL nvim
set EDITOR nvim

abbr exa exa -lahF --git
alias vim nvim
alias dotfilecfg 'git --git-dir=/home/niklas/dotfiles/ --work-tree=/home/niklas'
abbr vimcfg "vim ~/.config/nvim/init.vim"
abbr fishcfg "vim ~/.config/fish/config.fish"
abbr xclip "xclip -sel clip"
abbr cc "g++ -std=c++17 -Wall -Wextra"
abbr open xdg-open
alias firefox firefox-developer-edition
alias cal "cal -m"

set fish_greeting

