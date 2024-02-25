if [[ "$USER" == root  &&  -n "$SUDO_USER" ]]; then
  cp "/home/$SUDO_USER/.colorscheme" "$HOME"
fi

[[ -r "$HOME/.colorscheme" ]] || echo dark > "$HOME/.colorscheme"

read -r THEME < <(cat "$HOME/.colorscheme")

case "$THEME" in
  dark)
    export BAT_THEME=OneHalfDark
    ;;
  light)
    export BAT_THEME=gruvbox-light
    ;;
esac

export LS_COLORS=$(cat "$HOME/.lsc")

export FZF_MARKS_KEEP_ORDER=1

FZF_BASE_FLAGS=(
  "--color=$THEME"

  "--color=bg:-1,bg+:-1"
  "--color=fg:-1,fg+:-1"

  "--color=hl:-1:bold:underline,hl+:-1:bold:underline"
  "--color=gutter:-1"

  "--cycle"
  "--reverse"

  "--ansi"
  "--info=inline-right"

  "--bind=ctrl-k:up"
  "--bind=ctrl-j:down"

  "--bind=ctrl-u:preview-half-page-up"
  "--bind=ctrl-d:preview-half-page-down"

  "--bind=ctrl-o:toggle-preview-wrap"
  "--bind=ctrl-space:refresh-preview"
)

PREVIEW="bottom,border-rounded|right,border-rounded"
FZF_FLAGS=(
  "${FZF_BASE_FLAGS[@]}"
  "--history=$HOME/.fzf-history"
  #"--preview-window=right,border-rounded"
  #"--border=rounded"
  "--bind=right-click:toggle"
  "--bind=left-click:accept"
  "--bind=ctrl-f:jump"
  "--bind=ctrl-l:clear-query"
  "--bind=ctrl-p:prev-history"
  "--bind=ctrl-n:next-history"
  "--bind=ctrl-z:deselect-all"
  "--bind=ctrl-w:backward-kill-word"
  "--bind=ctrl-g:preview-bottom"
  #"'--bind=ctrl-x:change-preview-window($PREVIEW)'"
)

export FZF_DEFAULT_OPTS="${FZF_FLAGS[@]}"

[[ -n "$TMUX" ]] && eval $(tmux show-environment -s DISPLAY)

if [[ "$0" =~ zsh ]]; then
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  zstyle ':fzf-tab:*' fzf-flags "${FZF_BASE_FLAGS[@]}"
  source "$HOME/.fshenv"
fi
