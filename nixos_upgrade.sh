#!/usr/bin/env bash

nix-channel --update
nix-rebuild switch
nix flake update --flake /etc/nixos
nixos-rebuild switch --flake /etc/nixos
