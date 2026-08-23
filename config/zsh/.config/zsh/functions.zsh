mkcd() {
  [[ -n "${1:-}" ]] || { print 'Usage: mkcd DIRECTORY'; return 2; }
  mkdir -p -- "$1" && cd -- "$1"
}

croot() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || { print 'Not inside a Git repository.'; return 1; }
  cd -- "$root"
}

port() {
  [[ "${1:-}" == <-> ]] || { print 'Usage: port PORT'; return 2; }
  if (( $+commands[lsof] )); then lsof -nP -iTCP:"$1" -sTCP:LISTEN
  elif (( $+commands[ss] )); then ss -ltnp "sport = :$1"
  else print 'Install lsof or iproute2.'; return 1; fi
}

kuse() {
  (( $+commands[kubectl] && $+commands[fzf] )) || { print 'kubectl and fzf are required.'; return 1; }
  local context
  context=$(kubectl config get-contexts -o name | fzf --prompt='Kubernetes context > ') || return
  print -r -- "Will change kubectl context to: $context"
  read -q 'REPLY?Continue? [y/N] ' || { print; return 1; }
  print
  kubectl config use-context "$context"
}

knuse() {
  (( $+commands[kubectl] && $+commands[fzf] )) || { print 'kubectl and fzf are required.'; return 1; }
  local namespace
  namespace=$(kubectl get namespaces -o name | sed 's#^namespace/##' | fzf --prompt='Kubernetes namespace > ') || return
  print -r -- "Will change the current namespace to: $namespace"
  read -q 'REPLY?Continue? [y/N] ' || { print; return 1; }
  print
  kubectl config set-context --current --namespace="$namespace"
}

kwhere() {
  (( $+commands[kubectl] )) || { print 'kubectl is not installed.'; return 1; }
  print "Context:   $(kubectl config current-context 2>/dev/null || print undefined)"
  print "Namespace: $(kubectl config view --minify -o 'jsonpath={..namespace}' 2>/dev/null || print default)"
}

zja() {
  (( $+commands[zellij] )) || { print 'zellij is not installed.'; return 1; }
  zellij attach --create "${1:-work}"
}

zjl() {
  (( $+commands[zellij] )) || { print 'zellij is not installed.'; return 1; }
  [[ -n "${1:-}" ]] || { print 'Usage: zjl LAYOUT [SESSION]'; return 2; }
  zellij --layout "$1" --session "${2:-$1}"
}
