#!/bin/sh

sudo localectl set-keymap de-latin1-nodeadkeys

cd /tmp
git clone https://aur.archlinux.org/paru-bin.git
cd paru
makepkg-si

paru -S --needed - < paru-packages.txt

sudo gpasswd -a $USER input
libinput-gestures start autostart
sudo light -N 5

mkdir -p ~/Tools
cd ~/Tools
git clone https://github.com/neovim/neovim --depth 1
git clone https://github.com/rust-analyzer/rust-analyzer --depth 1

echo "
TODO:
    - Setup nerd-fonts-complete
    - Setup Rust (rustup.rs)
    - Setup dotfilecfg
    - Setup swapfile and hibernation
    - Setup i8kfan and dell-bios-fan-control
    - Edit /etc/acpi/handler.sh
    - Replace /bin/sh to be dash
"
