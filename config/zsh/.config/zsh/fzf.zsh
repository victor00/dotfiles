(( $+commands[fzf] )) || return 0

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height=60% --layout=reverse --border --info=inline}"
export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:---height=70% --layout=reverse --border --info=inline --prompt='history > ' --header='enter: inserir | ctrl-r: alternar ordem | esc: cancelar' --bind='ctrl-r:toggle-sort'}"

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

  # Warp owns Ctrl-R for its rich command search. Alt-R remains a direct,
  # terminal-independent search in the shared Zsh history.
  if (( $+widgets[fzf-history-widget] )); then
    bindkey -M emacs '^[r' fzf-history-widget
    bindkey -M viins '^[r' fzf-history-widget
  fi
fi

(( $+commands[fd] )) && export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
