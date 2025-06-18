#!/bin/sh

tmux new-session -s "Luna's Session" -d
tmux split-window -h
tmux -2 attach-session -d
