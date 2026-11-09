# Instalação, atualização e remoção — Google Antigravity

Este repositório contém somente o plugin Antigravity. Para Claude Code + Codex, use o projeto principal no GitHub. Os recursos Antigravity estão diretamente na raiz, com plugin.json e skills/.

## Pré-requisitos

- Antigravity com suporte a plugins e CLI agy disponível no terminal.
- Git caso prefira clonar para desenvolvimento e atualização local.
- Node.js 20+ para executar os testes offline (não é exigido para descobrir skills simples).
- Conexão ao GitHub para instalar por URL.

Consulte a documentação oficial do Google Antigravity caso o comando agy não esteja disponível na sua instalação. A extensão/IDE e a CLI podem apresentar diferenças de interface.

## 1. Instalação direta pelo GitHub

No terminal:

    agy plugin install https://github.com/victoralecrim11/observability-antigravity.git
    agy plugin list

Confirme que o plugin observability aparece como instalado/habilitado. Reinicie o IDE ou reabra o workspace.

## 2. Instalação local

    git clone https://github.com/victoralecrim11/observability-antigravity.git
    cd observability-antigravity
    agy plugin validate .
    agy plugin install .

O agy lê plugin.json na raiz do diretório indicado. Não é necessário apontar para uma pasta filha chamada antigravity.

Caminhos possíveis para instalação manual, quando aceitos pelo runtime:

- Global: ~/.gemini/config/plugins/observability/
- Projeto: .agents/plugins/observability/
- Windows: C:\Users\SEU_USUARIO\.gemini\config\plugins\observability\

Não confunda o diretório instalado com o clone de desenvolvimento.

## 3. Atualização

O GitHub sincroniza este repositório com a fonte canônica. Verifique o [status do workflow](https://github.com/victoralecrim11/observability-antigravity/actions/workflows/sync-from-source.yml) antes de atualizar a instalação local.

**Com clone local:**

    git pull --ff-only
    agy plugin validate .
    agy plugin install .
    agy plugin list

Ou rode o script na raiz do clone:

    # Windows
    powershell -ExecutionPolicy Bypass -File .\scripts\atualizar-plugin.ps1

    # Linux/macOS
    bash ./scripts/atualizar-plugin.sh

Ambos realizam pull com fast-forward (quando é um clone Git), validam e solicitam instalação local. Nunca descartam modificações locais automaticamente.

**Sem clone local:** repita a instalação a partir da URL GitHub. Se a CLI responder que o plugin já está instalado e não aceitar sobrescrever, faça a remoção explícita descrita abaixo e reinstale.

Uma sessão já aberta pode continuar usando a versão anterior: reinicie Antigravity ou reabra o workspace após atualização.

## 4. Desinstalar e reinstalar

    agy plugin uninstall observability
    agy plugin install https://github.com/victoralecrim11/observability-antigravity.git
    agy plugin list

A desinstalação remove a instalação do plugin no cliente; não exclui dados monitorados em Zabbix/Grafana. Não limpe outros diretórios ou caches indiscriminadamente.

## 5. Diagnóstico

- Plugin não aparece: agy plugin list; confirme a instalação e reabra o workspace.
- Erro de manifesto: agy plugin validate . a partir da raiz do clone; verifique plugin.json.
- Skills não aparecem: confirme diretórios skills/<nome>/SKILL.md e a versão do cliente.
- Falha de atualização: confira se o git pull foi fast-forward e se o workflow terminou com sucesso.
- MCP inacessível: mcp_config.json está intencionalmente vazio; dependências externas exigem autorização e configuração própria.
- Não confundir testes locais com execução real. Para testar a estrutura: npm run check.

## 6. Atualização automática do repositório

O workflow Sync from canonical source consulta a fonte principal a cada hora e também aceita workflow_dispatch. Ele valida o código-fonte, gera a distribuição e só faz commit quando os arquivos mudam. O job utiliza GITHUB_TOKEN restrito ao repositório Antigravity, sem token pessoal. Isso sincroniza o **repositório GitHub**; cada usuário ainda precisa atualizar sua instalação local.

A política de segurança mantém leitura como padrão e exige aprovação, backup, diff e rollback para qualquer mudança remota.
