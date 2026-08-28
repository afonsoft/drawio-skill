# Agent Skills Collection

A curated collection of high-performance Agent Skills and hooks designed to enhance AI capabilities across various runtimes (Claude Code, OpenCode, Devin, Cursor, etc.).

[![skills.sh](https://skills.sh/b/afonsoft/skills)](https://skills.sh/afonsoft/skills)

## 🚀 Overview

This repository provides specialized guidance and tools following the **Agent Skills Specification** (agentskills.io). Instead of generic prompts, these skills provide structured patterns, constraints, and reference materials that allow agents to perform complex software engineering tasks with production-grade quality.

## 🛠️ Skill Catalog & Correlation

The skills are organized into three main pillars: **Harness Engineering**, **Code Quality**, and **Extensibility**.

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

---

## 📦 Installation

### ⚡ via skills.sh (Recommended)
The fastest way to install and auto-detect your environment.
```bash
npx skills add afonsoft/skills
```

### 🌐 via Capafy Marketplace
Publish and earn from your skills on Capafy.
```bash
# Install Capafy Publisher
curl -sL "https://api.capafy.ai/public/capafy-publisher.zip" -o capafy.zip
unzip -q capafy.zip -d ~/.opencode/skills/capafy-publisher

# Publish a skill
cd ~/.opencode/skills/capafy-publisher
python3 packager.py publish-init --env claude_code --runtime-dir /path/to/skills --skill-dir /path/to/skills/skill-name
```

## 📖 How to use

1. **Install** the collection using one of the methods above.
2. **Invoke** a skill in your chat by mentioning its name (e.g., *"Use the create-agent-harness skill to setup this repo"*).
3. **Follow** the structured workflow provided by the skill (the agent will automatically load the `SKILL.md` and follow the lapped process).

## ⚖️ License
MIT - See `LICENSE`.

## 📊 Skills Catalog
Browse all available skills at [skills.sh](https://www.skills.sh/?q=afonsoft).
