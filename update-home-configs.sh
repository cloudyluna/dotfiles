#!/usr/bin/env bash

mkdir -p "$HOME/.config/git" "$HOME/.ssh"

cp -f ./.bashrc "$HOME/.bashrc"
cp -f ./.ssh/allowed_signers "$HOME/.ssh/allowed_signers"
cp -f ./.ssh/id_momo.pub "$HOME/.ssh/id_momo.pub"
cp -f ./git/config "$HOME/.config/git/config"
