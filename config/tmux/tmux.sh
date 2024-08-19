#!/usr/bin/env bash

SCRIPT=$(realpath "${BASH_SOURCE[0]}")
DIR=$(cd $(dirname "$SCRIPT") && pwd)

TMUX_CONFIG_DIR="$DIR"

shopt -s nullglob

source "$HOME/.profile"

START="$(date -u +%S.%N)"

for config in "$DIR"/??-*.conf; do
  if source "$config"; then
    NOW="$(date -u +%S.%N)"
    TIME="$(echo "scale=6; $NOW - $START" | bc)"
    START="$NOW"
    echo "'$config' took $TIME to load"
  fi
done
