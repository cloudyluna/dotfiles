#!/usr/bin/env bash

nix-channel --update
#nix-rebuild switch -- WTF DOES it do???
nix flake update --flake /etc/nixos
nixos-rebuild switch --flake /etc/nixos
