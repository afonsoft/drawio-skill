# SonarQube Review
An automated system for identifying and fixing code quality issues reported by SonarQube across any technology stack.

## 🎯 Purpose
Close the loop between automated static analysis and actual code fixes. It transforms a list of "smells" and "vulnerabilities" into verified, tested, and merged code improvements.

## 🛠️ How it Works
The skill provides an autonomous pipeline for quality remediation:
1. **Stack Detection**: Automatically identifies the project's language and build tools.
2. **Issue Extraction**: Downloads unresolved issues from SonarQube via API.
3. **Iterative Fix**: For each issue: Fix → Generate Test → Verify 100% coverage of changed lines → Format.
4. **Validation**: Uses local scan scripts to verify fixes before pushing to CI/CD.
5. **Metrics**: Generates a dashboard showing time saved and issues resolved.

## 🚀 Usage
Use this skill when you have a SonarQube report and need to clean up the codebase without manually triaging hundreds of issues.

## 🔗 Correlation
- **Automation**: This is the "automated" counterpart to the manual `code-review-and-quality` skill.
- **Testing**: Relies heavily on the TDD principles used in the `create-agent-harness` test sub-agents.
