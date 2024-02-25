WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu yes select=2
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:messages'     format '[%d]'
zstyle ':completion:*:warnings'     format '[No matches for: %d]'

## Ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'
## don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

zstyle ':fzf-tab:*' show-group brief
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags "${FZF_BASE_FLAGS[@]}"
zstyle ':fzf-tab:*' switch-group 'ctrl-p' 'ctrl-n'
zstyle ':fzf-tab:*' prefix ''

#zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
#zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
#        fzf-preview 'echo ${(P)word}'

#zstyle ':fzf-tab:*:*:*' popup-pad 30 0
FZF_MARKS_COMMAND=ftb-tmux-popup
