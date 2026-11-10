# Observability Dev Toolkit — Antigravity

Distribuição **exclusiva para Google Antigravity**, derivada do [Observability Dev Toolkit](https://github.com/victoralecrim11/plugin-observability-lab). Contém uma skill contextual, 21 workflows em referências, quatro especialidades, cinco agentes, três regras e scripts Node.js. O manifesto plugin.json está na raiz deste repositório.

> Os exemplos são genéricos. Nenhum host, segredo, documento ou dado corporativo é distribuído neste plugin.

## Instalação rápida

Com a CLI Antigravity (agy) instalada:

    agy plugin install https://github.com/victoralecrim11/observability-antigravity.git
    agy plugin list

Reabra o workspace ou reinicie o Antigravity para carregar os recursos. Para testar a instalação, peça em linguagem natural:

    Audite a configuração de um template Zabbix exportado, sem alterar o ambiente.

O Antigravity descobre as skills pela intenção do pedido; não presuma que os comandos com prefixo /observability: do Claude Code estarão disponíveis.

## Instalação local e validação

    git clone https://github.com/victoralecrim11/observability-antigravity.git
    cd observability-antigravity
    agy plugin validate .
    agy plugin install .
    agy plugin list

Alternativamente, para instalação manual, a CLI pode reconhecer o plugin quando colocado nas pastas utilizadas pela versão do runtime, por exemplo:

- Global: ~/.gemini/config/plugins/observability/
- Workspace: .agents/plugins/observability/

No Windows, o caminho global normalmente é C:\Users\SEU_USUARIO\.gemini\config\plugins\observability\. Prefira a CLI porque o mecanismo de descoberta pode variar com a versão.

## Atualização depois de mudanças na fonte

O GitHub Actions do repositório Antigravity acompanha o projeto principal automaticamente. A sincronização é agendada a cada hora e também pode ser iniciada manualmente em [Actions → Sync from canonical source](.github/workflows/sync-from-source.yml).

**Importante:** sincronizar o GitHub não reinstala automaticamente o plugin no seu computador.

Se você clonou este repositório:

    git pull --ff-only
    agy plugin validate .
    agy plugin install .

Ou execute o atualizador incluído:

    # Windows PowerShell
    powershell -ExecutionPolicy Bypass -File .\scripts\atualizar-plugin.ps1

    # macOS/Linux/Git Bash
    bash ./scripts/atualizar-plugin.sh

Se instalou diretamente por URL, reinstale a partir da URL atual e confirme a versão com agy plugin list. Se a CLI recusar a instalação porque já existe uma versão, siga a seção "Desinstalar e reinstalar" do [guia completo](docs/INSTALL.md). A rotina de atualização nunca remove um plugin automaticamente.

## Como usar

| Solicitação em linguagem natural | Skill principal |
| --- | --- |
| Investigar painel sem dados | diagnosticar-painel |
| Examinar template Zabbix | auditar-zabbix |
| Planejar HTTP monitor | monitorar-http |
| Criar dashboard a partir de artefatos | criar-dashboard |
| Planejar nova aplicação monitorada | integrar-aplicacao |
| Gerar plano de renomeação (dry-run) | renomear-hosts |

O comando conectar-ambiente verifica o ambiente existente em modo somente leitura, sem reinstalar ou reconfigurar integrações por padrão.

## Estrutura

- plugin.json: manifesto do Antigravity.
- mcp_config.json: MCP vazio; sem credenciais incluídas.
- skills/: uma entrada contextual, quatro especialidades e vinte e um workflows em referências.
- agents/: papéis de especialistas.
- rules/: guardrails documentados; carregamento depende do runtime.
- scripts/, tests/ e references/: auditorias e validação offline.

## Contribuir e validar

Para modificar procedimentos, edite a fonte no [repositório principal](https://github.com/victoralecrim11/plugin-observability-lab), rode os testes e deixe a sincronização atualizar este repositório.

    npm run check

Documentação: [instalação/atualização/remoção](docs/INSTALL.md) e [execuções GitHub Actions](https://github.com/victoralecrim11/observability-antigravity/actions).

A execução remota exige credenciais e aprovação explícita; testes offline não autorizam alteração em produção. Licença MIT.

## Importar configurações

Peça `importar-template` para um template Zabbix YAML/JSON/XML ou
`importar-dashboard` para um dashboard Grafana JSON. A skill usa ferramentas de
navegador, controle do computador ou API disponíveis e autorizadas; não oferece
acesso próprio nem ignora login/MFA. Ela inspeciona conflitos e dependências,
prepara backup/diff, executa o escopo autorizado e verifica o resultado.
Consulte [o procedimento completo](references/import-workflow.md).
