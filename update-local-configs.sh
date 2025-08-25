#!/usr/bin/env bash

SCRIPTS_PATH="./scripts"
SYSTEM_CONFIG_PATH="/etc/nixos"
LOCAL_CONFIG_PATH="./nixos"
HOME_MANAGER="home-manager"

cp -f "$SYSTEM_CONFIG_PATH/"*.nix "$LOCAL_CONFIG_PATH/"
cp -f "$SYSTEM_CONFIG_PATH/$HOME_MANAGER/"*.nix "$LOCAL_CONFIG_PATH/$HOME_MANAGER/"

if [[ -z "$(command -v nixfmt)" ]]
then
    exit
else
    nixfmt "$LOCAL_CONFIG_PATH/"*.nix
    nixfmt "$LOCAL_CONFIG_PATH/$HOME_MANAGER/"*.nix
fi

cp -f "$HOME/.local/bin/giadd.sh" "$SCRIPTS_PATH"
cp -f "$HOME/.local/bin/signed-giadd.sh" "$SCRIPTS_PATH"
cp -f "$HOME/.emacs" .
cp -f "$HOME/.quick-emacs.el" .
cp -f "$HOME/.summoner.toml" ./haskell
cp -f "$HOME/.config/alacritty/alacritty.toml" .
cp -f "$HOME/.tmux.conf" .

exit
