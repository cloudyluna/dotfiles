#!/usr/bin/env bash

# $1 can be 14d for 14 days
nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than "$1"
