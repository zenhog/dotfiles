zle -N edit-command-line

bindkey -e
bindkey -rp ""
bindkey -rp ""

bindkey "[D" backward-char
bindkey "[C" forward-char

bindkey "^R" fzf_history_search
bindkey "^T" transpose-Words
bindkey "^I" envupdate-and-complete
bindkey "^Q" zce
bindkey "^S" zce
bindkey "^Y" zce-kill
bindkey "^Q" search

bindkey "^X^S" git-status
bindkey "^X^R" histdrop

# bindkey "^Q" add-space
bindkey "^U" kill-whole-line
bindkey "^B" run-help

# zce-quote-WORD
# zce-goto-WORD
# zce-swap-WORD
# zce-goto-WORDend
# zce-goto-word
# zce-kill-WORD

# bindkey "" prepend-space
# bindkey "" append-pager
# bindkey "" remove-pager
# bindkey "^R" fzf-advanced-history
# bindkey "" fzf-cd
# bindkey "" fzf-marks
# bindkey "" fzf-file
# bindkey "" fzf-search
# bindkey "^X^I" expand-alias

bindkey "^X^X" execute-named-cmd

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

bindkey "^P" up-history
bindkey "^N" down-history

bindkey "^X^H" backward-char
bindkey "^X^L" forward-char

bindkey "^B" vi-forward-word
bindkey "^Z" vi-backward-word

bindkey "^W" vi-backward-kill-word
bindkey "^F" vi-forward-kill-word

bindkey "^X^I" edit-command-line
bindkey "^X^O" edit-command-line

bindkey "^@" marks

bindkey -r "^G"
bindkey -r "^J"
bindkey -r "^_"

bindkey -r "^Xa"
