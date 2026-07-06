#!/usr/bin/env bash

cp -f ./nixos/disko-config.nix /tmp || exit 1
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko-config.nix || exit 1
nixos-generate-config --no-filesystems --root /mnt || exit 1

cp -r ./nixos/* /mnt/etc/nixos/ || exit 1

nixos-install --flake /mnt/etc/nixos#nixos || exit 1

