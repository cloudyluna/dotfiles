#!/usr/bin/env bash


echo "This script remove profiles since n days ago"

# $1 can be 14d for 14 days
nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than "$1"
