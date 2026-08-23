# Segurança

- Nunca versione tokens, senhas, cookies, chaves SSH, kubeconfigs, `.env`, arquivos de autenticação ou `http-client.private.env.json`.
- Use `~/.config/zsh/local.zsh` para configuração local não sensível; prefira keyring/autenticação oficial para segredos.
- Git identity fica em `~/.config/git/local.config`.
- `git pr` delega autenticação ao GitHub CLI e nunca lê, imprime ou armazena tokens.
- `git cleanup-preview` somente lista branches merged; não existe exclusão implícita.
- `dev find` pode encontrar caminhos ocultos, mas exclui conteúdos `.git`; revise a
  saída antes de copiá-la para logs, issues ou conversas.
- `dev status` acessa somente endpoints públicos conhecidos, com timeout e sem tokens.
- `dev kube` lê configuração local por padrão; `--live` apenas consulta recursos e
  `use` exige confirmação antes de mudar o contexto local.
- `dev ports` não encerra processos. `dev open` abre somente uma URL localhost após
  invocação explícita.
- `db` nunca mantém conexões no repositório. O arquivo privado do Rainfrog usa modo
  `0600`; histórico, favoritos e exports ficam no XDG data home da máquina.
- Não passe URLs com senha em argumentos (`db -- --url ...`), pois elas podem aparecer
  no histórico/process list. Prefira configuração sem senha e prompt/keyring.
- Os dotfiles nunca executam login do GCloud nem trocam conta automaticamente.
- Helpers Kubernetes pedem confirmação para mudar contexto local. Nenhum helper altera recursos do cluster.
- Revise arquivos e seleção antes de enviá-los a Claude, Codex ou Cursor.

Se um segredo já apareceu em um arquivo, removê-lo não basta: revogue/rotacione pelo provedor apropriado.
