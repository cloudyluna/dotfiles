#!/usr/bin/env bash

# Add files and commit using pre-configured signature.

git add "$@" && git commit -S

exit
