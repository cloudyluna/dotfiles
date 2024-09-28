#!/usr/bin/env bash

# example: 1d (1 day)
FROM="$1"

nix-env --delete-generations "${FROM}"
nix-store --gc
