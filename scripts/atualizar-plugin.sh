#!/usr/bin/env bash
# Atualiza o Observability Dev Toolkit para Antigravity.
# Uso: bash scripts/atualizar-plugin.sh [--github | --help]
# Nunca remove um plugin/caches automaticamente.
set -euo pipefail
via_github=0
for arg in "$@"; do
  case "$arg" in
    --github) via_github=1;;
    -h|--help)
      echo "Uso: bash scripts/atualizar-plugin.sh [--github]"
      exit 0;;
    *) echo "Argumento desconhecido: $arg" >&2; exit 2;;
  esac
done
if ! command -v agy >/dev/null 2>&1; then
  echo "Erro: CLI agy não encontrada." >&2
  exit 1
fi
root="$(cd "$(dirname "$0")/.." && pwd)"
url="https://github.com/victoralecrim11/observability-antigravity.git"
source="$root"
if [[ "$via_github" -eq 1 || ! -d "$root/.git" ]]; then
  echo "Aviso: instalação pela URL GitHub (sem clone ou opção --github)."
  source="$url"
else
  if ! command -v git >/dev/null 2>&1; then
    echo "Erro: Git é necessário para atualizar o clone local." >&2
    exit 1
  fi
  echo "== git pull --ff-only"
  git -C "$root" pull --ff-only
  echo "== agy plugin validate"
  agy plugin validate "$root"
fi
echo "== agy plugin install"
if ! agy plugin install "$source"; then
  echo "Instalação falhou. Se a versão já estiver instalada, use manualmente agy plugin uninstall observability e depois agy plugin install pela URL." >&2
  exit 1
fi
agy plugin list
echo "Reinicie Antigravity ou reabra o workspace para carregar a versão."
