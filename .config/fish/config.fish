set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/go/bin
set PATH $PATH /snap/bin
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/CTF/tools/bin
set PATH $PATH $HOME/.config/yarn/global/node_modules/.bin/

set VISUAL nvim
set EDITOR nvim
set FZF_DEFAULT_COMMAND "rg --files --hidden --iglob '!.git/**'"

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
