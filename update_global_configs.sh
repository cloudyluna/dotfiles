#!/usr/bin/env bash

cp -f ./nixos/flake.nix /etc/nixos/
cp -f ./nixos/flake.lock /etc/nixos/
cp -f ./nixos/home.nix /etc/nixos/
cp -f ./nixos/pub_credentials.nix /etc/nixos/

exit
