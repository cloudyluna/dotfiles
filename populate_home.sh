#!/usr/bin/env bash

mkdir -p "$HOME/.local/bin"
cp -f giadd.sh signed_giadd.sh "$HOME/.local/bin"
cp -f .emacs .quick-emacs.el ./haskell/.summoner.toml "$HOME"
