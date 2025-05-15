#!/usr/bin/env sh

# https://wiki.archlinux.org/title/Language_Server_Protocol
# https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md


set -e

sudo test 1


install() {
   PKGS=$1
   if pacman -Q $PKGS > /dev/null 2> /dev/null; then
      echo "$PKGS already installed."
   else
      echo "$PKGS not found. Installing..."
      sudo pacman --noconfirm -S $PKGS
   fi
}

aur_install() {
   PKGS=$1
   REPO=https://aur.archlinux.org/$PKGS.git
   if pacman -Q $PKGS > /dev/null 2> /dev/null; then
      echo "$PKGS already installed."
   else
      echo "$PKGS not found. Installing..."
      rm -rf /tmp/aur_install
      git clone $REPO /tmp/aur_install
      pushd /tmp/aur_install
      makepkg -si --needed --noconfirm
      popd
      rm -rf /tmp/aur_install
   fi
}

go_install() {
   PKGS=$1
   REPO=$2
   if which $PKGS > /dev/null 2> /dev/null; then
      echo "$PKGS already installed."
   else
      echo "$PKGS not found. Installing..."
      go install $REPO@latest
   fi
}

npm_install() {
   PKGS=$1
   if which $PKGS > /dev/null 2> /dev/null; then
      echo "$PKGS already installed."
   else
      echo "$PKGS not found. Installing..."
      sudo npm i -g $PKGS
   fi
}


install base-devel
install git
install neovim

# CMake
install cmake
install python-build
install python-installer
install python-pdm
aur_install cmake-format
aur_install python-pdm-pep517
aur_install cmake-language-server

# Go
install go
install gopls
aur_install golangci-lint
# Need to add ~/go/bin to PATH
# https://templ.guide/commands-and-tools/ide-support/#neovim--050
go_install templ github.com/a-h/templ/cmd/templ

# HTML
install vscode-html-languageserver

# HTMX
install npm
install rust
npm_install htmx-lsp

# XML
install libxml2

# Zig
install zig
install zls

