#!/usr/bin/env bash

SCRIPT=$(realpath "${BASH_SOURCE[0]}")
DIR=$(cd $(dirname "$SCRIPT") && pwd)

TMUX_CONFIG_DIR="$DIR"

VMUX_SCRIPT="$TMUX_CONFIG_DIR/vmux.sh"

shopt -s nullglob

"$VMUX_SCRIPT"

#source "$HOME/.profile"

for config in "$DIR"/??-*.conf; do
    source "$config"
done
