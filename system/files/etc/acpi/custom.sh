#!/bin/bash

notify() (
    SOCK=/tmp/rofi_notification_daemon
    REGS=/tmp/.X11-unix/registrations

    local widget="$1"

    shift

    for user in "${users[@]}"; do
        su -l "$user" -c "echo dela:ACPI | socat - UNIX-CONNECT:$SOCK"
        su -l "$user" -c "notify-send -a ACPI -t 5000 ACPI '${*}'"
        su -l "$user" -c "widget $1 timeout"
    done
)

case "$1" in
    ac_adapter)
        case "$2" in
            AC*|AD*)
                case "$4" in
                    00000000)
                        notify battery Battery Discharging
                    ;;
                    00000001)
                        notify battery Battery Charging
                    ;;
                esac
                ;;
        esac
        ;;
    jack/headphone)
        case "$2" in
            HEADPHONE)
                case "$3" in
                    unplug)
                        notify playback Headphone Unplugged
                        ;;
                    plug)
                        notify playback Headphone Plugged
                        ;;
                esac
        esac
        ;;
    *)
        ;;
esac
