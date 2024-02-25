stty -ixon

ZLE_RPROMPT_INDENT=0

[[ -r "$HOME/.profile" ]] && source "$HOME/.profile"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

preexec() {
  source "$HOME/.zshenv"
  #clear -x
}

chpwd() {
    echo
    lsd
}

#command_not_found_handler() {
#    #open "$@"
#}

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zhistory"

if [[ -d "$HOME/.gnupg" ]]; then
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

    gpgconf --launch gpg-agent
    gpg-connect-agent updatestartuptty /bye &>/dev/null
fi

[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

setopt nullglob

[[ -f "$HOME/.zinitrc" ]] && source "$HOME/.zinitrc"

for rcfile in $HOME/.zsh.d/*; do
    [[ -d "$rcfile" ]] || [[ -r "$rcfile" ]] && source $rcfile
done

zstyle ':completion:*' completer _complete _ignored _files
autoload -U compinit && compinit
autoload -U edit-command-line

fpath+=("$HOME/.zsh.d/functions")

alias ls='ls --color=auto '
alias ll='ls -l '
alias la='ls -A '
alias lla='ls -lA '
alias grep='grep -i --color=auto '
alias du='du -H '
alias df='df -H '
