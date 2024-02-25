#!/usr/bin/env bash

SCRIPT=$(realpath "${BASH_SOURCE[0]}")
DIR=$(cd $(dirname "$SCRIPT") && pwd)

VMUX="$DIR/vmux.sh"
TMUX_CONFIG="$DIR/tmux.conf"

COPYTK="python3 $DIR/copytk/copytk.py"
CMDSYM=➡

function command:cursor
{
    local word=$(tmux display -p '#{copy_cursor_word}')
    local x=$(tmux display -p '#{copy_cursor_x}')
    local y=$(tmux display -p '#{copy_cursor_y}')
    local match=$(tmux display -p '#{search_match}')

    tmux display "Word under cursor: '$word' at ($x, $y), match: '$match'"
}

function command:lastcmd
{
    tmux copy-mode
    tmux send-keys -X search-backward "$CMDSYM"
    tmux send-keys -X search-again
}

function command:prevcmd
{
    #tmux send-keys -X rectangle-off
    local word=$(tmux display -p '#{copy_cursor_word}')
    if [[ "$word" != "$CMDSYM" ]]; then
        tmux send-keys -X cursor-left
    fi
    tmux send-keys -X search-backward "$CMDSYM"
    #tmux send-keys -X rectangle-on
    #tmux send-keys -X start-of-line
}

function command:nextcmd
{
    #tmux send-keys -X rectangle-off
    local word=$(tmux display -p '#{copy_cursor_word}')
    if [[ "$word" = "$CMDSYM" ]]; then
        tmux send-keys -X cursor-right
    fi
    tmux send-keys -X search-forward "$CMDSYM"
    #tmux send-keys -X rectangle-on
    #tmux send-keys -X start-of-line
}

function command:reload {
    tmux source "$TMUX_CONFIG"
}

function command:colors {
    source "$DIR/10-theme.conf"
    source "$DIR/30-options.conf"
}

function command:extract {
    local pane
    read -r pane < <(tmux display -p '#S:#I.#P')
    tmux new-window -n grep bash -c \
        "tmux capture-pane -pNq -t ${pane} | fzfgrep"
}

function command:copy {
    tmux run -b "python $HOME/.bin/copytk easycopy --search-nkeys 1"
}

function command:host
{
    local session=$(tmux display -p '#S')
    local host dummy

    IFS=$'/\n' read -r -d '' host dummy <<< "$session"

    printf "%s\n" "$host"
}

function command:istty
{
    local tty=$(tmux display -p '#{client_termname}')

    if [[ "$tty" = fbterm || "$tty" = linux ]]; then
        return 0
    fi
    return 1
}

function command:isfullscreen
{
    local session=$(tmux display -p '#S')
    local fullscreen=$(tmux show -sv "@fullscreen-$session")
    if [[ -n "$fullscreen" ]]; then
        return 0
    fi
    return 1
}

function command:isttyscreen
{
    command:istty || command:isfullscreen
}

function command:setfullscreen
{
    local session=$(tmux display -p '#S')
    tmux set -s "@fullscreen-$session" 1
}

function command:unsetfullscreen
{
    local session=$(tmux display -p '#S')
    tmux set -su "@fullscreen-$session"
}

function command:status-left
{
    if command:isttyscreen; then
        echo -n " #(date '+%R'): #S "
    fi
}

function command:status-right
{
    if command:isttyscreen; then
        echo -n "#(cat /tmp/tmux-status)"
    fi
}


function command:setremote
{
    local host=$(command:host)
}

function fixclient
{
    local session=$(tmux display -p '#S')

    if [[ -n "$SSH_CONNECTION" ]]; then
        tmux set status on
        tmux switch-client -T main
        tmux set key-table main
        return
    fi

    local host dummy

    IFS=$'/\n' read -r -d '' host dummy <<< "$session"

    if [[ "$host" = menu ]]; then
        tmux set status off
        tmux switch-client -T menu
        tmux set key-table menu
    #elif [[ "$host" = $(hostname) ]]; then
    else
        tmux set status on
        tmux switch-client -T main
        tmux set key-table main
    #else
    #    tmux set status off
    #    tmux switch-client -T send
    #    tmux set key-table send
    fi
}

function onlyclient
{
    local tty session clients

    session=$(tmux display -p '#S')

    tty=$(tmux display -p '#{client_tty}')

    readarray -t clients < <(tmux list-clients -t "$session" | \
        grep -v "^${tty}:" |  awk -F: '{print $1}')

    for client in "${clients[@]}"; do
        tmux detach -t "${client}"
    done

    tmux reload
    tmux refresh-client -S
}

function clipsync
{
    if [[ -n "$DISPLAY" ]]; then
        local tmuxdata=$(tmux show-buffer | base64)
        local xseldata=$(xsel -ob | base64)

        if [[ "$tmuxdata" != "$xseldata" ]]; then
            echo -n "$tmuxdata" | base64 -d | xsel -ib
        fi
    fi
}

function sendback
{
    if [[ -n "$SSH_CONNECTION" ]]; then
        local session=$(tmux display -p '#S')
        local tunport=$(tmux show -gv '@tunport')

        if [[ -z "$tunport" ]]; then
            return
        fi

        local data=$(tmux show-buffer | base64)

        tmux delete-buffer

        exec 3<>"/dev/tcp/localhost/$tunport"
        echo "$data" >&3

        exec 3>&-
        exec 3<&-
        return
    fi

    clipsync
}

function hook:session-created
{
    if [[ -z "$REMOTE_CONNECTION" ]]; then
        local session=$(tmux display -p '#S')
        local host dummy

        IFS=$'/\n' read -r -d '' host dummy <<< "$session"

        tmux set -s "@host-$session" "$host"
        if [[ "$host" != $(hostname) ]]; then
            tmux set -s "@remote-$session" 1
        fi
    fi
}

function hook:session-closed
{
    # do remote down
    local session=$(tmux display -p '#S')
}

function hook:client-attached
{
    fixclient
    sendtty
    onlyclient
    tmux set -g set-titles-string '#{client_session}'
}

function hook:client-session-changed
{
    fixclient
    sendtty
    onlyclient
}

function hook:after-set-buffer
{
    sendback
}

function hook:after-load-buffer
{
    sendback
}

function main
{
    readarray -t HOOKS < <(declare -F | awk '/hook:/ {print $3}')

    for hook in "${HOOKS[@]}"; do
        tmux set-hook -g "${hook#hook:}" "run '$VMUX $hook'"
    done

    readarray -t COMMANDS < <(declare -F | awk '/command:/ {print $3}')

    local index=0
    for cmd in "${COMMANDS[@]}"; do
        tmux set -s "command-alias[$index]" "${cmd#command:}"="run '$VMUX $cmd'"
        ((index++))
    done

    exit 0
}

if [[ "$#" -eq 0 ]]; then
    main
fi

"$@"
