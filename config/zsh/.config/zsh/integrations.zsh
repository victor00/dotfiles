if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
else
  if (( $+commands[rbenv] )); then eval "$(rbenv init - zsh)"; fi
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
fi

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
  z() {
    local destination
    if (( $# == 0 )); then
      builtin cd -- "$HOME"
    elif [[ "$1" == '-' && $# == 1 ]]; then
      builtin cd -- "${OLDPWD:-$HOME}"
    elif destination=$(zoxide query -- "$@" 2>/dev/null); then
      builtin cd -- "$destination"
    elif (( $+commands[dev] )) && destination=$(command dev project "$*" 2>/dev/null); then
      builtin cd -- "$destination"
      zoxide add "$destination" >/dev/null 2>&1 || true
    elif (( $+commands[dev] )); then
      local -a matches
      matches=("${(@f)$(command dev directory "$*" 2>/dev/null)}")
      if (( ${#matches[@]} == 1 )); then
        destination="${matches[1]}"
      elif (( ${#matches[@]} > 1 )) && (( $+commands[fzf] )); then
        destination=$(printf '%s\n' "${matches[@]}" | fzf --prompt='directory > ' --height=60% --layout=reverse --border) || return
      else
        print -u2 -- "z: no unique directory matched: $*"
        return 1
      fi
      builtin cd -- "$destination"
      zoxide add "$destination" >/dev/null 2>&1 || true
    else
      print -u2 -- "z: no directory or project matched: $*"
      return 1
    fi
    if [[ -t 1 && -z "${NO_COLOR:-}" && "${TERM:-}" != dumb ]]; then
      print -nP -- '%F{green}✓ '
      print -rn -- "$PWD"
      print -P -- '%f'
    else
      print -r -- "✓ $PWD"
    fi
  }
fi
(( $+commands[starship] )) && eval "$(starship init zsh)"

# Opt-in only: export DOTFILES_AUTO_ZELLIJ=1 in local.zsh.
if [[ "${DOTFILES_AUTO_ZELLIJ:-0}" == 1 && -z "${ZELLIJ:-}" && -z "${SSH_CONNECTION:-}" && "${TERM:-}" != dumb && -z "${VSCODE_INJECTION:-}" ]]; then
  (( $+commands[zellij] )) && exec zellij attach --create work
fi
