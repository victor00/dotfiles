export LANG="${LANG:-en_US.UTF-8}"
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"
export LESS="${LESS:--FRX}"

# Vivid orange for eza build files and Markdown documentation (ANSI color 202).
export EZA_COLORS="${EZA_COLORS:+$EZA_COLORS:}bu=1;4;38;5;202:*.md=1;4;38;5;202"

typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/bin" $path)
[[ -d /snap/bin ]] && path+=(/snap/bin)
export PATH
