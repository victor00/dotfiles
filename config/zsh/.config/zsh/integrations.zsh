if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
else
  if (( $+commands[rbenv] )); then eval "$(rbenv init - zsh)"; fi
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
fi

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"

# Opt-in only: export DOTFILES_AUTO_ZELLIJ=1 in local.zsh.
if [[ "${DOTFILES_AUTO_ZELLIJ:-0}" == 1 && -z "${ZELLIJ:-}" && -z "${SSH_CONNECTION:-}" && "${TERM:-}" != dumb && -z "${VSCODE_INJECTION:-}" ]]; then
  (( $+commands[zellij] )) && exec zellij attach --create work
fi
