#!/usr/bin/env bash

nixos-rebuild boot --ask-sudo-password --flake /etc/nixos --no-update-lock-file --no-write-lock-file --diff
