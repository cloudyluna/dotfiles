#!/usr/bin/env bash

cp -f /etc/nixos/flake.nix .
cp -f /etc/nixos/flake.lock .
cp -f /etc/nixos/home.nix .
cp -f /etc/nixos/pub_credentials.nix .

if [[ -z "$(command -v nixfmt)" ]]
then
    exit
else
    nixfmt ./*.nix
fi
