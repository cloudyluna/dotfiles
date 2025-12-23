#!/usr/bin/env bash

SCRIPTS_PATH="./scripts"
SYSTEM_CONFIG_PATH="/etc/nixos"
LOCAL_CONFIG_PATH="./nixos"

cp -f "$SYSTEM_CONFIG_PATH/"*.nix "$LOCAL_CONFIG_PATH/"
cp -f "$SYSTEM_CONFIG_PATH/"flake.lock "$LOCAL_CONFIG_PATH/"

if [[ -z "$(command -v nixfmt)" ]]
then
    exit
else
    nixfmt "$LOCAL_CONFIG_PATH/"*.nix
fi

cp -f "$HOME/.local/bin/giadd.sh" "$SCRIPTS_PATH"
cp -f "$HOME/.local/bin/signed-giadd.sh" "$SCRIPTS_PATH"
cp -f "$HOME/.emacs" .
cp -f "$HOME/.quick-emacs.el" .
cp -f "$HOME/.summoner.toml" ./haskell
cp -f "$HOME/.config/alacritty/alacritty.toml" .
cp -f "$HOME/.tmux.conf" .
cp -f "$HOME/.wezterm.lua" .

exit
