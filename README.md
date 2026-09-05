# Agent Skills Collection

A curated collection of high-performance Agent Skills and hooks designed to enhance AI capabilities across various runtimes (Claude Code, OpenCode, Devin, Cursor, etc.).

[![skills.sh](https://skills.sh/b/afonsoft/skills)](https://skills.sh/afonsoft/skills)
[![Spec Validation](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml/badge.svg?job=validate-spec)](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml)
[![Quality Check](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml/badge.svg?job=validate-quality)](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml)
[![Security Scan](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml/badge.svg?job=security-scan)](https://github.com/afonsoft/skills/actions/workflows/skills-validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Agent Skills Spec](https://img.shields.io/badge/Agent%20Skills-Spec-blue)](https://agentskills.io)

## 🚀 Overview

This repository provides specialized guidance and tools following the **Agent Skills Specification** (agentskills.io). Instead of generic prompts, these skills provide structured patterns, constraints, and reference materials that allow agents to perform complex software engineering tasks with production-grade quality.

## 🛠️ Skill Catalog & Correlation

The skills are organized into four main pillars: **Harness Engineering**, **Code Quality**, **Extensibility**, and **MCP Integrations**.

### 🏗️ Harness Engineering
*Foundation for creating and managing AI agents.*
- **`create-agent-harness`**: The starting point. Use this to bootstrap a complete agent environment (CLAUDE.md, rules, skills) in any repo.
- **`create-readme`**: Professionalizes the repository landing page. Generates evidence-based READMEs and SemVer-compliant CHANGELOGs.
- **`observability-and-instrumentation`**: Once the harness is set, use this to ensure the agent's actions and the application's behavior are visible and diagnosable in production.

### 💎 Code Quality & Review
*Ensuring the output meets professional standards.*
- **`code-review-and-quality`**: The primary gatekeeper. Performs multi-axis reviews (correctness, security, performance) before any code is merged.
- **`sonarqube-review`**: The automated auditor. Integrates with SonarQube to identify and fix technical debt and smells systematically.

### 🔌 Extensibility & Integration
*Expanding what the agent can actually do.*
- **`building-mcp-servers`**: The power-user tool. Teaches agents how to build their own Model Context Protocol (MCP) servers to connect to any API or database.
- **`drawio-architecture`**: Visual intelligence. Merges architecture diagram authoring with the official draw.io MCP server for automated system design.

### 🔗 MCP Integrations
*Configuring, authenticating, and using external MCP servers.*
- **`composio-mcp`**: Connects AI agents to 1000+ external apps (Gmail, GitHub, Slack, Notion, Linear, Jira) via Composio. CLI-first path (`ak_*` project key) with MCP fallback (`ck_*` consumer key via `x-consumer-api-key` header). Includes setup and verify scripts, per-platform config reference, and troubleshooting for the `ck_` vs `ak_` auth boundary.
- **`notebooklm-mcp`**: Google NotebookLM (Gemini Notebook) integration via the `nlm` CLI and `notebooklm-mcp` server. Cookie-based auth for headless servers with two methods (OpenClaw CDP provider + manual `cookies.txt` file) and a desktop auto-mode fallback. Includes verify and cookie-extraction helper scripts, plus per-platform MCP config reference.

---

## 📦 Installation

### ⚡ via skills.sh (Recommended)
The fastest way to install and auto-detect your environment.
```bash
npx skills add afonsoft/skills
```

## 📣 Publish on Skill Directories

### SkillsLLM
[SkillsLLM](https://skillsllm.com/) indexes open-source skills for Claude Code, Codex CLI, and ChatGPT. Sign in with GitHub and submit this repository through [Submit a Skill](https://skillsllm.com/submit). Submissions are security-scanned before listing.

### Awesome Skills
[Awesome Skills](https://awesomeskill.ai/) discovers open-source `SKILL.md` skills from GitHub. Keep each skill in its own directory with a valid `SKILL.md`, optional `scripts/`, `references/`, or `assets/`, and a repository README. Submit the repository through the site's **Submit a Skill** form for directory listing.

### SkillHub
[SkillHub](https://www.skill-marketplace.com/) aggregates skills from GitHub sources. Open **Sources** → **Add Source**, then use:

- **Name:** `afonsoft/skills`
- **Repository URL:** `https://github.com/afonsoft/skills`
- **Source Type:** `GitHub Repo`
- **Branch:** `main`
- **Skills Path:** `/skills`

SkillHub imports the collection from this source and lists each valid `SKILL.md` directory in its marketplace.

## 📖 How to use

1. **Install** the collection using one of the methods above.
2. **Invoke** a skill in your chat by mentioning its name (e.g., *"Use the create-agent-harness skill to setup this repo"*).
3. **Follow** the structured workflow provided by the skill (the agent will automatically load the `SKILL.md` and follow the lapped process).

## ⚖️ License
MIT - See `LICENSE`.

## 🛠️ Skill Development Tools

### skillxp
[skillxp](https://skillxp.dev/) observes skill loading behavior across harnesses (Claude Code, Codex CLI, Antigravity). Stage a skill in a fresh fixture, invoke the harness headlessly, and see what actually reached the model with transcript evidence. Install via `brew install agent-ecosystem/tap/skillxp` or `npm install -g skillxp`. Use `skillxp harnesses` to list supported platforms and `skillxp observe -harness <name> -install ./my-skill ...` to trace skill activation and phrase loading.

## 📊 Skills Catalog
Browse all available skills at [skills.sh](https://www.skills.sh/?q=afonsoft).
