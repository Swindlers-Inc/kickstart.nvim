#!/usr/bin/env sh

# https://wiki.archlinux.org/title/Language_Server_Protocol
# https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md


set -e

# sudo test 1


install() {
   PKGS=$1
   if brew ls --versions $PKGS > /dev/null 2> /dev/null; then
      echo "$PKGS already installed."
   else
      echo "$PKGS not found. Installing..."
      brew install $PKGS
   fi
}

go_install() {
   PKGS=$1
   REPO=$2
   if which $PKGS > /dev/null 2> /dev/null; then
      echo "$PKGS already installed."
   else
      echo "$PKGS not found. Installing..."
      GOPROXY=direct go install $REPO@latest
   fi
}

npm_install() {
   PKGS=$1
   if which $PKGS > /dev/null 2> /dev/null; then
      echo "$PKGS already installed."
   else
      echo "$PKGS not found. Installing..."
      # nvm use v20.10.0
      sudo PATH="/opt/homebrew/bin:$PATH" $(which npm) i -g --no-proxy $PKGS
   fi
}


# install base-devel
install git
install neovim

# C / C++
install clang-format

# CMake
install cmake
# install python-build
# install python-installer
# install python-pdm
# aur_install cmake-format
# aur_install python-pdm-pep517
install cmake-language-server

# Go
install go
install gopls
install golangci-lint
# Need to add ~/go/bin to PATH
# https://templ.guide/commands-and-tools/ide-support/#neovim--050
go_install templ github.com/a-h/templ/cmd/templ

# HTML
# install vscode-html-languageserver
install vscode-langservers-extracted

# HTMX
install npm
install node
install rust
# TODO npm_install htmx-lsp

# XML
install libxml2

# Zig
install zig
install zls

