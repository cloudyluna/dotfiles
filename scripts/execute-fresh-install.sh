#!/usr/bin/env bash

cp -f ./nixos/disko-config.nix /tmp
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko-config.nix
nixos-generate-config --no-filesystems --root /mnt

cp -r ./nixos/* /mnt/etc/nixos/

nixos-install --flake /mnt/etc/nixos#nixos

