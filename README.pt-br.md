# Coleção de Agent Skills

Uma coleção curada de Agent Skills e hooks de alta performance projetados para aprimorar capacidades de IA em diversos runtimes (Claude Code, OpenCode, Devin, Cursor, etc.).

[![skills.sh](https://skills.sh/b/afonsoft/skills)](https://skills.sh/afonsoft/skills)
[![Spec Validation](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml/badge.svg?job=validate-spec)](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml)
[![Quality Check](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml/badge.svg?job=validate-quality)](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml)
[![Security Scan](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml/badge.svg?job=security-scan)](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Agent Skills Spec](https://img.shields.io/badge/Agent%20Skills-Spec-blue)](https://agentskills.io)

## 🚀 Visão Geral

Este repositório fornece orientação e ferramentas especializadas seguindo a **Agent Skills Specification** (agentskills.io). Em vez de prompts genéricos, estas skills fornecem padrões estruturados, restrições e materiais de referência que permitem aos agentes realizar tarefas complexas de engenharia de software com qualidade de produção.

## 🛠️ Catálogo de Skills e Correlação

As skills estão organizadas em quatro pilares principais: **Engenharia de Harness**, **Qualidade de Código**, **Extensibilidade** e **Integrações MCP**.

### 🏗️ Engenharia de Harness
*Fundação para criação e gerenciamento de agentes de IA.*
- **`create-agent-harness`**: O ponto de partida. Use para inicializar um ambiente completo de agente (CLAUDE.md, AGENTS.md, regras, skills) em qualquer repositório. Suporta Claude Code, Devin, OpenCode, Cursor, Gemini e Antigravity.
- **`create-readme`**: Profissionaliza a página inicial do repositório. Gera READMEs baseados em evidência e CHANGELOGs compatíveis com SemVer.
- **`observability-and-instrumentation`**: Depois que o harness está configurado, use para garantir que as ações do agente e o comportamento da aplicação sejam visíveis e diagnosticáveis em produção.

### 💎 Qualidade e Revisão de Código
*Garantindo que a saída atenda a padrões profissionais.*
- **`code-review-and-quality`**: O guardião principal. Realiza revisões multi-eixo (corretude, segurança, performance) antes de qualquer código ser merged.
- **`sonarqube-review`**: O auditor automático. Integra com SonarQube para identificar e corrigir débito técnico e code smells sistematicamente.

### 🔌 Extensibilidade e Integração
*Expandindo o que o agente pode realmente fazer.*
- **`building-mcp-servers`**: A ferramenta de power-user. Ensina agentes a construir seus próprios servidores Model Context Protocol (MCP) para conectar a qualquer API ou banco de dados.
- **`drawio-architecture`**: Inteligência visual. Combina autoria de diagramas de arquitetura com o servidor MCP oficial do draw.io para design automatizado de sistemas.

### 🔗 Integrações MCP
*Configurando, autenticando e usando servidores MCP externos em todas as plataformas de agente suportadas.*
- **`composio-mcp`**: Conecta agentes de IA a mais de 1000 aplicativos externos (Gmail, GitHub, Slack, Notion, Linear, Jira) via Composio. Caminho CLI-first (`ak_*` chave de projeto) com fallback MCP (`ck_*` chave de consumidor via header `x-consumer-api-key`). Inclui script de setup multiplataforma (trata `serverUrl` vs `url`, `mcp` vs `mcpServers`, `environment` vs `env` em Claude Code/Desktop, Cursor, Devin CLI/Desktop, OpenCode, Antigravity IDE/CLI, OpenClaw), script de verificação, referência de config por plataforma e matriz de peculiaridades cross-platform.
- **`notebooklm-mcp`**: Integração do Google NotebookLM (Gemini Notebook) via CLI `nlm` e servidor `notebooklm-mcp`. Autenticação baseada em cookies para servidores headless com três métodos (OpenClaw CDP preferencial, arquivo manual `cookies.txt`, auto desktop + cópia) e script de setup multiplataforma cobrindo todas as 8 plataformas de agente suportadas. Inclui verificação, helper de extração de cookies, referência de config por plataforma e matriz de peculiaridades cross-platform.

---

## 📦 Instalação

### ⚡ via skills.sh (Recomendado)
A forma mais rápida de instalar e auto-detectar seu ambiente.
```bash
npx skills add afonsoft/skills
```

## 📣 Publicar em Diretórios de Skills

### SkillsLLM
[SkillsLLM](https://skillsllm.com/) indexa skills open-source para Claude Code, Codex CLI e ChatGPT. Entre com GitHub e submeta este repositório através de [Submit a Skill](https://skillsllm.com/submit). Submissões são escaneadas por segurança antes da listagem.

### Awesome Skills
[Awesome Skills](https://awesomeskill.ai/) descobre skills `SKILL.md` open-source do GitHub. Mantenha cada skill em seu próprio diretório com um `SKILL.md` válido, `scripts/`, `references/` ou `assets/` opcionais, e um README do repositório. Submeta o repositório através do formulário **Submit a Skill** do site para listagem no diretório.

### SkillHub
[SkillHub](https://www.skill-marketplace.com/) agrega skills de fontes do GitHub. Abra **Sources** → **Add Source**, então use:

- **Name:** `afonsoft/skills`
- **Repository URL:** `https://github.com/afonsoft/skills`
- **Source Type:** `GitHub Repo`
- **Branch:** `main`
- **Skills Path:** `/skills`

SkillHub importa a coleção desta fonte e lista cada diretório `SKILL.md` válido em seu marketplace.

## 📖 Como usar

1. **Instale** a coleção usando um dos métodos acima.
2. **Invoque** uma skill no seu chat mencionando seu nome (ex.: *"Use a skill create-agent-harness para configurar este repo"*).
3. **Siga** o workflow estruturado fornecido pela skill (o agente carregará automaticamente o `SKILL.md` e seguirá o processo).

## ⚖️ Licença
MIT - Veja `LICENSE`.

## 🛠️ Ferramentas de Desenvolvimento de Skills

### skillxp
[skillxp](https://skillxp.dev/) observa o comportamento de carregamento de skills em harnesses (Claude Code, Codex CLI, Antigravity). Stage uma skill em um fixture novo, invoque o harness headless, e veja o que realmente chegou ao modelo com evidência de transcript. Instale via `brew install agent-ecosystem/tap/skillxp` ou `npm install -g skillxp`. Use `skillxp harnesses` para listar plataformas suportadas e `skillxp observe -harness <name> -install ./my-skill ...` para rastrear ativação de skills e carregamento de frases.

## 📊 Catálogo de Skills
Navegue todas as skills disponíveis em [skills.sh](https://www.skills.sh/?q=afonsoft).
