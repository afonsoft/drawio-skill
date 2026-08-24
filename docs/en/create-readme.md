# Create README and CHANGELOG
This skill automates the generation of professional project documentation, ensuring that READMEs and Changelogs are evidence-based and follow industry standards.

## 🎯 Purpose
Eliminate "documentation debt" by transforming the actual state of the code and git history into a clear, navigable, and professional `README.md` and `CHANGELOG.md`.

## 🛠️ How it Works
The skill prevents the "generic template" trap by forcing a Discovery Phase first. It analyzes the project's DNA (stack, architecture, commits) before writing. It then applies two strict standards:
- **README**: A comprehensive 11-section structure covering everything from business value to technical implementation.
- **CHANGELOG**: Strict adherence to "Keep a Changelog" and Semantic Versioning (SemVer).

## 🚀 Usage
Use this skill when initializing a new repository, taking over a legacy project with poor docs, or preparing a release. It ensures that anyone (human or agent) landing in the repo knows exactly what the project is, how to run it, and what has changed.

## 🔗 Correlation
- **Harness Integration**: This skill is often the final step in the `create-agent-harness` workflow to ensure the repository's landing page is professional.
- **Quality**: A professional README is part of the "Readability" axis in `code-review-and-quality`.
