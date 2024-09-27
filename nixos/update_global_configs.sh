#!/usr/bin/env bash

cp -f ./flake.nix /etc/nixos/
cp -f ./flake.lock /etc/nixos/
cp -f ./home.nix /etc/nixos/
cp -f ./pub_credentials.nix /etc/nixos/

exit
