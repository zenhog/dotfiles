#!/usr/bin/env bash

regdir=/tmp/.X11-unix/registrations

source $HOME/.profile

cleanup() {
    rm -rf "$regdir/$USER"
    kill -HUP %1
}

register() {
    mkdir -p -m 777 "$regdir/$USER"
    echo "$DISPLAY" > "$regdir/$USER/display"

    echo $(cat /sys/class/tty/tty0/active) > "$regdir/$USER/tty"
}

trap cleanup EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap
touchpad=$HOME/.Xtouchpad

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f "$touchpad" -a -x /usr/bin/synclient ]; then
    cat "$touchpad" | while read line; do
        synclient "$(echo "$line" | tr -d ' ')"
    done
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -d $HOME/.xinitrc.d ] ; then
    for f in $HOME/.xinitrc.d/?*.sh ; do
        [ -f "$f" ] && . "$f"
    done
    unset f
fi

if [ -d $HOME/.xresources.d ]; then
    for f in $HOME/.xresources.d/*; do
        if [ -f "$f" -o -L "$f" ]; then
            xrdb -merge "$f"
        fi
    done
    unset f
fi

if [ -x /usr/bin/xhost -a -x /usr/bin/id ]; then
    xhost +si:localuser:`id -un` > /dev/null 2>&1
fi

if [ -x /usr/bin/xset ]; then
    xset c 100
    xset b off
    xset s off
    xset led off
    xset m default
    xset dpms 0 0 0
fi

runsvdir "${HOME}"/.xsv &

register

awesome

exit 0
