#!/bin/sh

set -ex

# Note:
# For bundled dependencies,
#   https://aur.archlinux.org/packages/neovim-git
# is a good place to look. In particular, I found that libvterm 0.2 is
# not supported, and installed the libvterm-0.1 package from the AUR.

make distclean
rm -rf build

git pull --ff-only

mkdir build
cd build
cmake -G Ninja -D CMAKE_BUILD_TYPE=RelWithDebInfo ..
mold --run ninja
sudo ninja install
