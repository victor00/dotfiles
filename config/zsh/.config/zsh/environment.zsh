export LANG="${LANG:-en_US.UTF-8}"
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"
export LESS="${LESS:--FRX}"

typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/bin" $path)
[[ -d /snap/bin ]] && path+=(/snap/bin)
export PATH
