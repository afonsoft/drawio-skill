---
name: create-readme
license: MIT
description: Use when generating or updating professional README.md and CHANGELOG.md files for a project. Covers repository analysis, stack detection, and alignment with Keep a Changelog and SemVer standards. Do NOT use for API-reference docs (use dedicated doc tooling) or for licenses/governance documents.
metadata:
  version: "1.0.0"
  visibility: public
  author: afonsoft
  url: https://github.com/afonsoft/skills
---

# Create README and CHANGELOG

## Overview
Transforms a raw repository into a well-documented project by generating professional `README.md` and `CHANGELOG.md` files based on empirical evidence from the codebase, git history, and configuration files.

## When to Use
- When a project lacks a README or CHANGELOG.
- When existing documentation is outdated, incomplete, or inconsistent.
- Before shipping a new version to ensure the changelog is up to date.
- When restructuring a project and the existing documentation no longer reflects the architecture.

## Process

### Phase 1: Discovery (Evidence Gathering)
Before writing a single line, analyze the target repository:
- **Structure**: Root directory tree and top-level files.
- **Stack**: `package.json`, `*.csproj`, `pom.xml`, `pyproject.toml`, `Dockerfile`, etc.
- **CI/CD**: `.github/workflows/` and pipeline definitions.
- **History**: `git log --oneline -n 50` to identify recent features and fixes.
- **Existing Docs**: Current `README.md` and `CHANGELOG.md`.

**Requirement**: Output a "Discovery Summary" containing Stack, Architecture, CI/CD, and identified gaps before proceeding to generation.

### Phase 2: README.md Authoring
Generate the README following this strict order:
1. **Title & Badges**: Project name and detectable status badges.
2. **Project Description**: Rich functional and strategic overview.
3. **Repository Structure**: Hierarchical tree with short descriptions per item.
4. **Tech Stack**: Explicit list of languages, frameworks, and cloud services.
5. **Architecture**: Layers and patterns (e.g., Clean Architecture, DDD).
6. **System Flow**: Mermaid diagrams or textual flow descriptions.
7. **Getting Started**: Prerequisites, env vars, and run commands.
8. **Tests & Coverage**: Execution commands and coverage metrics.
9. **Business & Technical Views**: Strategic goals vs. implementation details.
10. **License & Status**: License type and current project state.
11. **Links**: Internal references and link to `CHANGELOG.md`.

**Rules**:
- Reuse existing content where applicable.
- Only include sections where concrete evidence exists.
- Default to English (en-us) to match the skill catalog; only use another language if the repository's existing documentation is consistently written in that language.

### Phase 3: CHANGELOG.md Authoring
Follow the [Keep a Changelog](https://keepachangelog.com/) and [SemVer](https://semver.org/) standards:
- **Structure**: Maintain a `[Unreleased]` section at the top.
- **Categories**: Use `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, and `Security`.
- **Source**: Populate categories by analyzing recent git commits.
- **Linking**: Link version numbers to tags or compare URLs.

### Phase 4: Delivery & Verification
1. **Branching**: Create a dedicated branch `feature/{YYYYMMDD}-readme-changelog`.
2. **Linting**: Run a Markdown linter if available.
3. **Commit**: Use Conventional Commits: `docs(readme): update README and CHANGELOG`.
4. **Reporting**: Provide a summary of changes; do not open the PR automatically.

## Common Mistakes
- **Inventing Info**: Stating a feature exists without finding it in the code.
- **Generic Templates**: Using a "one size fits all" README that doesn't reflect the actual architecture.
- **Ignoring History**: Creating a changelog that doesn't match the git commit history.
- **Manual PRs**: Opening the PR without summarizing the changes for the human reviewer.

## Verification
- [ ] Discovery Summary was produced before generation.
- [ ] README includes all required sections based on available evidence.
- [ ] CHANGELOG follows the "Keep a Changelog" format.
- [ ] No secrets or credentials were accidentally included.
- [ ] Branch naming follows the project's convention.
