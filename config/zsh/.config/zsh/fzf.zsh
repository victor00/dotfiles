(( $+commands[fzf] )) || return 0

# fzf 0.48+ provides shell integration directly. Ubuntu 22.04's 0.29 does not.
if [[ -o zle ]]; then
  if fzf --help 2>&1 | command grep -q -- '--zsh'; then
    source <(fzf --zsh)
  elif [[ -r "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
  else
    [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [[ -r /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height=60% --layout=reverse --border --info=inline}"
(( $+commands[fd] )) && export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
