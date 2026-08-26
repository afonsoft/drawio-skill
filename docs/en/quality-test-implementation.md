# Multi-Language Code Quality & Test Coverage
A structured intervention for improving code quality, reducing technical debt, and raising test coverage in .NET, Java, and Python repositories.
## 🎯 Purpose
Stabilize the build, fix static-analysis warnings (Roslyn/Sonar, SpotBugs/Checkstyle, Bandit/Ruff), resolve security CVEs, apply SOLID/DDD/Clean Architecture, and produce a measured improvement report — without auto-opening a Pull Request.
## 🛠️ How it Works
1. **Preparation**: Clone, branch `feature/{YYYYMMDD}-{name}`, detect build/test tooling.
2. **Static Analysis**: Fix logging, async, cleanup, exception, web/API, security, and documentation categories per language.
3. **Architecture**: Apply SOLID, DDD, and Clean Architecture only where it reduces warnings or improves testability.
4. **Tests & Coverage**: Stabilize the suite, add BDD-style tests, hit language targets (.NET/Python 90%, Java 85%).
5. **Delivery**: Update README/CHANGELOG, use Conventional Commits, emit a Detailed Technical Summary — the user opens the PR manually.
## 🚀 Usage
Use when a repository has accumulated warnings, low coverage, or CVEs and needs a whole-repo quality push. For a single change, use `code-review-and-quality`; for automated SonarQube remediation, use `sonarqube-review`.
## 🔗 Correlation
- **Review**: Complements `code-review-and-quality` (manual, per-change) with an automated, repo-wide pass.
- **Security**: Shares CVE-closure steps with `sonarqube-review`.
