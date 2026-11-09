# Observability Dev Toolkit — Antigravity

Distribuição **nativa para Google Antigravity**, com manifesto plugin.json na raiz, 23 skills invocáveis, agentes, regras e scripts Node.js.

Este repositório é gerado a partir da fonte pública [Observability Dev Toolkit](https://github.com/victoralecrim11/plugin-observability-lab) (Claude Code + Codex). Os procedimentos são mantidos no projeto principal e atualizados aqui pelo workflow GitHub Actions.

## Estrutura

- plugin.json — manifesto Antigravity.
- mcp_config.json — configuração MCP vazia (sem segredos).
- skills/ — 4 skills técnicas e 19 operacionais.
- agents/ — papéis especializados.
- rules/ — regras declarativas para o agente.
- scripts/ e references/ — validação offline e documentação.

## Validar

Clone este repositório e execute:

    npm run check

Para instalar no Antigravity, use o mecanismo de instalação disponível na versão do seu cliente, apontando para **a raiz deste repositório**, e valide a descoberta das skills. O comportamento de agentes e regras depende do runtime.

## Sincronização

O workflow sync-from-source.yml consulta a fonte pública a cada hora e também pode ser acionado manualmente em Actions -> Sync from canonical source -> Run workflow. Ele gera a distribuição, executa os testes e atualiza os arquivos sem requerer token pessoal adicional. O GitHub Actions utiliza GITHUB_TOKEN restrito a este repositório.

Não edite arquivos gerados diretamente: altere os workflows e skills no repositório-fonte e solicite sincronização.

## Segurança

Nenhum dado, endpoint, credencial ou documento de cliente está incluído. Este plugin começa em modo somente leitura; modificações exigem autorização específica, backup, diff, testes e rollback.

Licença MIT.
