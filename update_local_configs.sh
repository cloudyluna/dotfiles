#!/usr/bin/env bash

cp -f /etc/nixos/flake.nix ./nixos/
cp -f /etc/nixos/flake.lock ./nixos
cp -f /etc/nixos/home.nix ./nixos
cp -f /etc/nixos/pub_credentials.nix ./nixos
cp -f /etc/nixos/niri.nix ./nixos

if [[ -z "$(command -v nixfmt)" ]]
then
    exit
else
    nixfmt ./nixos/*.nix
fi

cp -f "$HOME/.local/bin/giadd.sh" .
cp -f "$HOME/.local/bin/signed_giadd.sh" .
cp -f "$HOME/.local/bin/qgit.sh" .
cp -f "$HOME/.emacs" .
cp -f "$HOME/.quick-emacs.el" .
cp -f "$HOME/.summoner.toml" ./haskell
cp -f "$HOME/.config/alacritty/alacritty.toml" .
cp -f "$HOME/.tmux.conf" .

exit
