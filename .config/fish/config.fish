set PATH $PATH $HOME/.cargo/bin

abbr exa exa -laF --git
alias vim nvim
alias dotfilecfg 'git --git-dir=/home/niklas/dotfiles/ --work-tree=/home/niklas'
abbr vimcfg "vim ~/.config/nvim/init.vim"
abbr fishcfg "vim ~/.config/fish/config.fish"
abbr xclip "xclip -sel clip"
abbr cc "g++ -std=c++17 -Wall -Wextra"
abbr open xdg-open
alias firefox firefox-developer-edition

function fish_greeting
    neofetch
end

