function prependpath() {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
            ;;
    esac
}

function prependmanpath() {
    case ":$MANPATH:" in
        *:"$1":*)
            ;;
        *)
            MANPATH="$1${MANPATH:+:$MANPATH}"
            ;;
    esac
}

unset PATH

prependpath '/bin'
prependpath '/sbin'
prependpath '/usr/bin'
prependpath '/usr/sbin'
prependpath '/usr/local/bin'
prependpath '/usr/local/sbin'

prependpath "$HOME/.node_modules/bin"
prependpath "$HOME/.cargo/bin"
prependpath "$HOME/.luarocks/bin"
prependpath "$HOME/.local/bin"
prependpath "$HOME/.bin"
prependpath "$HOME/.oldbin"

prependmanpath "$HOME/.local/share/man"

export PATH
export MANPATH="$MANPATH:"

umask 022

unset prependpath
unset prependmanpath

export EDITOR=vim
export VISUAL=vim

export PAGER=less
export LESS="-rFX"
export LESSOPEN="|- lesspipe.sh %s"

export BROWSER=elinks

if [[ -n "$DISPLAY" ]]; then
    export BROWSER="firefox -p main"
fi

if [[ -z "$PULSE_SERVER" ]]; then
    export PULSE_SERVER="/tmp/user/$USER/pulse/native"
fi

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$HOME/.dbus-session"

export COLORSCHEME="$HOME/.colorscheme"

if [[ "$USER" == root ]] || [[ -n "$SUDO_USER" ]]; then
  export COLORSCHEME="/home/$SUDO_USER/.colorscheme"
fi

#source "$HOME/.zshenv"
