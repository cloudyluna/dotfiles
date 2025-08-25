#!/usr/bin/env bash

echo "Collect unused packages from nix store."
echo "Also will delete older generated packages of n days range."


# example: 1d (1 day)
FROM="$1"

nix-env --delete-generations "${FROM}"
nix-store --gc
