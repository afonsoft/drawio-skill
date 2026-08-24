---
name: sonarqube-review
license: UNLICENSED
description: Use when fixing SonarQube code quality issues automatically across any language or framework
author: afonsoft
url: https://github.com/afonsoft/skills
subagent: false
user-invokable: true
argument-hint: "<project-name> [--new-code-only] [--issues=<issue-id1,issue-id2,...>]"
metadata:
  version: "1.0.0"
  visibility: public
---

# SonarQube Review Skill

## Objetivo
Corrigir automaticamente as issues reportadas pelo SonarQube, **independentemente da linguagem ou framework**, seguindo um processo estruturado com:
- Análise de issues
- Checklist de correções
- Testes unitários e cobertura (agnóstico de stack)
- Documentação de revisão
- Atualização do .gitignore

## ⚙️ Configuração de Variáveis de Ambiente

A skill suporta múltiplas edições do SonarQube através de variáveis de ambiente. A detecção é automática baseada na disponibilidade das variáveis (em ordem de prioridade):

> **⚠️ IMPORTANTE:** Por segurança, NUNCA leia, print ou inspecione o valor de variáveis de ambiente que contenham tokens. O máximo que você pode saber é em qual variável o token está armazenado. Use as variáveis diretamente nos comandos sem acessar seu conteúdo.

### Variáveis Disponíveis

#### Para URL Customizada (Prioridade Máxima)
- `SONARQUBE_CUSTOM_URL`: URL base do SonarQube customizado
- `SONARQUBE_CUSTOM_TOKEN`: Token de autenticação para o SonarQube customizado
- `SONARQUBE_CUSTOM_EDITION`: Edição do SonarQube customizado (`open` ou `enterprise`, padrão: `open`)

#### Para SonarQube Enterprise
- `SONARQUBE_ENTERPRISE_TOKEN`: Token de autenticação para o SonarQube Enterprise
- `SONARQUBE_ENTERPRISE_URL`: URL base do SonarQube Enterprise (obrigatório, sem fallback)

#### Para SonarQube Open (Padrão)
- `SONARQUBE_OPEN_TOKEN`: Token de autenticação para o SonarQube Open (preferencial)
- `SONAR_TK`: Token de autenticação para o SonarQube Open (fallback para compatibilidade, usado apenas se SONARQUBE_OPEN_TOKEN não estiver definido)
- `SONARQUBE_OPEN_URL`: URL base do SonarQube Open (obrigatório, sem fallback)

### Suporte a Branches

As edições Enterprise e Custom com edição `enterprise` suportam automaticamente o parâmetro `branch` na API. A skill detecta automaticamente o branch atual usando `git branch --show-current`.

## 🌍 Suporta Qualquer Stack
- ✅ **Linguagens:** Java, Kotlin, Python, JavaScript, TypeScript, C#, C++, Go, Ruby, PHP, Scala, PLSQL, VB.NET e outras
- ✅ **Frameworks:** Spring, Django, Flask, FastAPI, Express, React, Vue, Angular, .NET, ASP.NET, Gin, Rails, etc.
- ✅ **Qualquer ferramenta de testes** que gere relatórios de cobertura
- ✅ **Qualquer gerenciador de dependências** (Maven, Gradle, npm, pip, dotnet, etc.)

## 🔍 Detecção Automática de Stack

A skill detecta automaticamente a stack do projeto analisando os arquivos de configuração. Carregue o script `references/detect-stack.sh` para determinar a stack e configurar os comandos apropriados.

### Padrões de Detecção

| Arquivo | Stack | Gerenciador | Ferramenta de Testes | Ferramenta de Cobertura |
|---|---|---|---|---|
| `pom.xml` | Java/Kotlin | Maven | Maven Surefire/Failsafe | JaCoCo |
| `build.gradle` / `build.gradle.kts` | Java/Kotlin | Gradle | Gradle Test | JaCoCo |
| `package.json` | JavaScript/TypeScript | npm/yarn/pnpm | Jest/Vitest/Mocha | Istanbul |
| `requirements.txt` / `pyproject.toml` | Python | pip | pytest | Coverage.py |
| `.csproj` / `.sln` | C#/.NET | dotnet | dotnet test | OpenCover/Cobertura |
| `go.mod` | Go | go mod | go test | go test -cover |
| `Gemfile` | Ruby | bundler | rspec/minitest | SimpleCov |
| `composer.json` | PHP | composer | phpunit | phpunit |
| `build.sbt` | Scala | sbt | sbt test | sbt coverage |

### Script de Detecção

Carregue o script `references/detect-stack.sh` para detectar automaticamente a stack do projeto e configurar os comandos apropriados.

## Angular-Specific Support

### Detecção Angular
- Arquivo: `angular.json` ou `angular-cli.json`
- Gerenciador: npm, yarn, pnpm
- Framework de Testes: Karma + Jasmine ou Jest
- Ferramenta de Cobertura: Istanbul (ng test --code-coverage)

### Comandos Angular

```bash
# Testes com cobertura
ng test --code-coverage --watch=false

# Linting
ng lint

# Formatação
npx prettier --write src/
npx eslint --fix src/

# Build para validação
ng build --configuration=production
```

### Scripts Angular
- `references/validate-angular.sh` — Validação Angular (ng lint, ng test, prettier, eslint)

### Template de Teste Angular
- `references/templates/test-angular.md` — Template para testes Karma/Jasmine com TestBed

## C# .NET-Specific Support

### Detecção C# .NET
- Arquivo: `.csproj` ou `.sln`
- Gerenciador: dotnet CLI
- Framework de Testes: xUnit, NUnit, MSTest
- Ferramenta de Cobertura: dotnet test /p:CollectCoverage=true

### Comandos C# .NET

```bash
# Testes com cobertura
dotnet test /p:CollectCoverage=true /p:CoverageFormat=cobertura

# Linting e análise
dotnet build /p:RunAnalyzersDuringBuild=true

# Formatação
dotnet format

# Restore de pacotes
dotnet restore
```

### Scripts C# .NET
- `references/validate-csharp.sh` — Validação C#/.NET (dotnet build, dotnet test, dotnet format)

### Template de Teste C# .NET
- `references/templates/test-csharp.md` — Template para testes xUnit/Moq

## SonarQube Local Validation

### Script de Validação Local
Carregue o script `references/sonar-local-scan.sh` para executar SonarQube localmente e revalidar as correções antes do commit.

```bash
# Executar scan local
bash references/sonar-local-scan.sh
```

### Configuração SonarQube Local
O script `sonar-local-scan.sh` requer:
- `sonar-scanner` instalado (disponível em https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/scanners/sonarscanner/)
- Java 17+ e `jq`
- Arquivo `sonar-project.properties` na raiz do projeto (opcional, script configura automaticamente)

### Instalação do sonar-scanner

```bash
# Linux/macOS (manual): descompacte o ZIP do SonarScanner e adicione <caminho>/bin ao PATH
export PATH="$HOME/sonar-scanner-<versao>/bin:$PATH"

# Ou use o instalador deste repositório
./install-skill-tools.sh --sonar
```

### Exemplo de sonar-project.properties
```properties
sonar.projectKey=my-project
sonar.sources=src
sonar.tests=tests
sonar.exclusions=**/node_modules/**,**/dist/**,**/bin/**,**/obj/**
sonar.coverage.exclusions=**/*Tests.cs,**/Program.cs
sonar.cs.vscoveragexml.reportPaths=coverage.xml
sonar.javascript.lcov.reportPaths=coverage/lcov.info
```

## Fluxo de Trabalho

### Pré Steps
- Salve o horário que você iniciou a execução da skill para medir o tempo gasto.
- Ao concluir a execução, salve o horário de término para calcular o tempo total gasto.
- Compare o tempo gasto, com o "effort" estimado na issue, para avaliar a eficiência da skill (trazer quantos % de ganho de tempo ou perdas de tempo, em relação ao esforço estimado).

### Fase 1: Análise e Preparação

1. **Detectar Stack do Projeto**
   - Carregue o script `references/detect-stack.sh` para detectar automaticamente a stack
   - O script retornará: `STACK`, `BUILD_TOOL`, `TEST_FRAMEWORK`, `COVERAGE_TOOL`
   - Configure os comandos apropriados baseados na stack detectada
   - Se não for possível detectar automaticamente, pergunte ao usuário

2. **Verificar arquivo de issues**
   - Consulte o nome do projeto, geralmente é o nome da pasta do workspace.
   - Se não tiver na raiz do projeto crie a pasta .sonar_devin_auto_fix/
   - **⚠️ SEGURANÇA CRÍTICA:** Jamais print o valor de variáveis de ambiente que contenham token ou secrets. NUNCA leia o valor de tokens para sua memória - o máximo que você pode saber é em qual variável de ambiente o token está armazenado. Use as variáveis diretamente nos comandos bash sem nunca inspecionar seu conteúdo.
   - Baixe as issues do projeto:
    Se o usuário expecificar o nome do projeto, use ele, caso contrário tente usar o nome da pasta do workspace, e se mesmo assim não for possível, solicite o nome do projeto para o usuário.
    Se o usuário fornecer as issues a serem corrigidas, consulte usando o parâmetro `issues` e passando uma lista csv com os IDs das issues, caso contrário baixe todas as issues não resolvidas do projeto usando a API do SonarQube.
    Se o usuário solicitar para corrigir só as issues novas, baixe as issues não resolvidas, e adicione o filtro `inNewCodePeriod` como true.

    **Detecção automática de edição do SonarQube:**
    A skill detecta automaticamente qual edição usar baseada nas variáveis de ambiente disponíveis (em ordem de prioridade):

    1. **Custom URL** (prioridade máxima): Se `$SONARQUBE_CUSTOM_URL` estiver definida
    2. **Enterprise**: Se `$SONARQUBE_ENTERPRISE_TOKEN` estiver definido
    3. **Open**: Se `$SONARQUBE_OPEN_TOKEN` ou `$SONAR_TK` estiver definido
    4. **Erro**: Se nenhum dos acima, aborta e solicita a configuração das variáveis de ambiente (não há URL automática/fallback).

    **Download das issues com detecção automática:**
    Carregue o script de referência `references/download-issues.sh` e execute-o.

   - Indent o arquivo de issues baixado, usando o script `references/jsonf.sh`
   - Confirme que `.sonar_devin_auto_fix/sonarqube_issues.json` existe e é parseável
   - Baseie todas as correções exclusivamente nas issues listadas nesse JSON

2. **Criar ToDo Board**
   - Crie o arquivo `.sonar_devin_auto_fix/SONAR_FIX_TODO_BOARD.md`
   - Use o formato:
     ```markdown
     # SonarQube Review ToDo Board

     ## Checklist de issues do SonarQube

     - [ ] Issue <ID> — Regra: <RuleKey> — Arquivo: `<caminho/do/arquivo>` — Linha: <linha>
           Resumo: <mensagem curta da issue>
     ```
   - Agrupe por arquivo, se possível
   - Ordene por gravidade (Blocker → Critical → Major → Minor → Info)

### Fase 2: Correção de Issues

Para cada issue, execute em ordem:

1. **Modifique o código** - Resolva a issue específica
2. **Gere testes automaticamente** (se aplicável) - Carregue o template de teste apropriado para a stack detectada
3. **Atualize testes** - Garanta 100% de cobertura das linhas alteradas
4. **Rode testes** - Execute a suíte de testes unitários
5. **Verifique cobertura** - Confirme 100% de cobertura das linhas alteradas
6. **Rode linters específicos** - Execute linters da stack para validar a correção
7. **Formate o código** - Execute formatters da stack para manter consistência
8. **Atualize o ToDo Board** - Marque a issue como `[x]` quando corrigida

### Fase 3: Documentação e Finalização

1. **Atualizar .gitignore**
   - Abra `.gitignore` na raiz do projeto
   - Adicione a linha: `.sonar_devin_auto_fix/**`
   - Somente se não existir equivalente

2. **Gerar Guia de Revisão**
   - Crie `.sonar_devin_auto_fix/SONAR_FIX_REVIEW_NOTES.md`
   - Inclua seções:
     - **Resumo das alterações**: número de issues corrigidas e tipos de correções
     - **Como revisar**: instruções para o dev revisar as mudanças
     - **Pontos de atenção**: lógica sensível que foi alterada
     - **Testes**: como rodar testes e cobertura
     - **Verificação pós-revisão**: validações finais

3. **Validação final**
   - O scan do SonarQube será executado pelo pipeline de CI/CD após o merge
   - Confirme que o código está limpo e os testes passando

4. **Gerar Dashboard de Métricas**
   - Crie `.sonar_devin_auto_fix/SONAR_FIX_METRICS.html`
   - Inclua:
     - Tempo gasto vs effort estimado (em %)
     - Número de issues corrigidas por tipo (bug, code smell, vulnerability, hotspot)
     - Cobertura antes/depois
     - Regressões evitadas
     - Stack detectada e ferramentas utilizadas

## 🛠️ Ferramentas Externas Integradas

A skill integra automaticamente ferramentas externas por stack para validar e formatar o código após as correções.

### Linters por Stack

| Stack | Linter | Comando |
|---|---|---|
| Java/Kotlin | Checkstyle, PMD | `mvn checkstyle:check pmd:check` |
| JavaScript/TypeScript | ESLint | `npx eslint src/` |
| Python | Pylint, Flake8 | `python -m pylint src/` |
| C#/.NET | StyleCop, Roslyn Analyzers | `dotnet build /p:RunAnalyzersDuringBuild=true` |
| Go | golint, golangci-lint | `golangci-lint run` |
| Ruby | RuboCop | `bundle exec rubocop` |
| PHP | PHPStan | `vendor/bin/phpstan analyse` |
| Scala | Scalastyle, Scapegoat | `sbt scalastyle scapegoat` |

### Formatters por Stack

| Stack | Formatter | Comando |
|---|---|---|
| Java/Kotlin | Spotless, Google Java Format | `mvn spotless:apply` |
| JavaScript/TypeScript | Prettier | `npx prettier --write src/` |
| Python | Black, isort | `python -m black src/` |
| C#/.NET | dotnet format | `dotnet format` |
| Go | gofmt, goimports | `gofmt -w .` |
| Ruby | Rufo | `bundle exec rufo` |
| PHP | PHP CS Fixer | `vendor/bin/php-cs-fixer fix` |

### Ferramentas de Cobertura por Stack

| Stack | Ferramenta | Comando |
|---|---|---|
| Java/Kotlin | JaCoCo | `mvn jacoco:report` |
| JavaScript/TypeScript | Istanbul | `npx vitest run --coverage` |
| Python | Coverage.py | `python -m coverage run -m pytest` |
| C#/.NET | OpenCover, Cobertura | `dotnet test /p:CollectCoverage=true /p:CoverageFormat=cobertura` |
| Go | go test -cover | `go test -cover ./...` |
| Ruby | SimpleCov | `bundle exec rspec --coverage` |
| PHP | phpunit --coverage-clover | `vendor/bin/phpunit --coverage-clover=coverage.xml` |
| Scala | sbt coverage | `sbt clean coverage test coverageReport` |

### SonarLint e SonarScanner

A skill pode utilizar SonarLint e SonarScanner para validação local antes do commit:

**SonarLint (IDE Integration):**
- Disponível para IntelliJ IDEA, VS Code, Eclipse
- Valida código em tempo real
- Pode ser invocado via linha de comando para validação batch

**SonarScanner CLI:**
- Para scans locais antes do push
- Validação offline de correções
- Comando: `sonar-scanner -Dsonar.projectKey=<project> -Dsonar.sources=src`

### Scripts de Validação

A skill carrega scripts de referência para validação automática por stack:

- `references/validate-java.sh` — Validação Java/Kotlin (Checkstyle, PMD, Spotless, JaCoCo)
- `references/validate-js.sh` — Validação JavaScript/TypeScript (ESLint, Prettier, Vitest)
- `references/validate-python.sh` — Validação Python (Pylint, Flake8, Black, pytest)
- `references/validate-csharp.sh` — Validação C#/.NET (Roslyn Analyzers, dotnet format, dotnet test)
- `references/validate-go.sh` — Validação Go (golangci-lint, gofmt, go test)
- `references/validate-ruby.sh` — Validação Ruby (RuboCop, Rufo, rspec)
- `references/validate-php.sh` — Validação PHP (PHPStan, PHP CS Fixer, phpunit)
- `references/validate-scala.sh` — Validação Scala (Scalastyle, Scapegoat, sbt)

## 🎨 Templates de Testes por Stack

A skill gera testes automaticamente baseados em templates específicos por stack. Carregue o template apropriado da pasta `references/templates/`:

- `test-java.md` — Template para testes JUnit/Mockito
- `test-kotlin.md` — Template para testes KotlinTest/Mockk
- `test-python.md` — Template para testes pytest/unittest
- `test-javascript.md` — Template para testes Jest/Vitest
- `test-typescript.md` — Template para testes TypeScript
- `test-csharp.md` — Template para testes xUnit/Moq
- `test-go.md` — Template para testes Go
- `test-ruby.md` — Template para testes RSpec/Minitest
- `test-php.md` — Template para testes PHPUnit
- `test-scala.md` — Template para testes ScalaTest/ScalaCheck

### Testes e Cobertura
- ✅ **100% de cobertura das linhas modificadas** (verificado em relatório de cobertura)
- ✅ **Nenhuma exclusão de cobertura**, como:
  - Comentários: `// NOSONAR`, `// no sonar`, `# noqa`, `# pragma: no cover`, etc.
  - Decoradores/Atributos: `@IgnoreCoverage`, `ExcludeFromCodeCoverage`, `@Suppress`, etc.
  - Pragmas do compilador: `#pragma`, etc.
  - IMPORTANTE: Se o arquivo já tiver exclusão de cobertura, remova-a, e implemente testes para a correção e também para o restante do código do arquivo, garantindo cobertura total.
- ✅ Remova arquivos de scanners do SonarQube que possam estar presentes, como `sonar-project.properties`, `sonar-scanner.properties`, etc., Remova também outros scanners, como o `SonarScanner for Maven` geralmente presente no POM.xml, pois nossa pipeline é autonoma e não depende desses arquivos para funcionar. (Mantenha por enquanto apenas configurações relacionadas ao SonarQube em arquivos .csproj).
- ✅ Todos os testes passando
- ✅ Relatório de cobertura disponível (formato: OpenCover, JaCoCo, Cobertura, Istanbul, etc.)

### Qualidade de Código
- ✅ Sem novos smells de código ou violations do SonarQube
- ✅ Sem regressões de funcionalidade
- ✅ Sem problemas de performance óbvios
- ✅ Alterações pontuais e mínimas
- ✅ Código segue convenções e padrões do projeto
- ✅ Sem mudanças desnecessárias em áreas não relacionadas à issue

### Lógica de Negócio
- ✅ **Não altere** lógica de negócio sem necessidade extrema
- ✅ Se for necessário alterar pontos sensíveis (regras de negócio, cálculos críticos, fluxos principais):
  - Minimize a alteração
  - Documente claramente no guia de revisão
  - Justifique por que foi inevitável
  - Adicione testes específicos para validar a alteração

### Dependências
- ✅ **Não adicione** dependências desnecessárias
- ✅ Limite-se ao escopo das correções do SonarQube
- ✅ Se for absolutamente necessário adicionar uma dependency, justifique e documente
- ✅ Verifique se não há conflitos com as dependências existentes

## Checklist de Conclusão

- [ ] Todas as issues analisadas e categorizadas no SONAR_FIX_TODO_BOARD.md
- [ ] Todas as issues corrigidas com 100% de cobertura de testes
- [ ] Todos os testes passando
- [ ] .gitignore atualizado com `.sonar_devin_auto_fix/**`
- [ ] SONAR_FIX_REVIEW_NOTES.md gerado com instruções completas
- [ ] Nenhuma nova issue introduzida (verificado via revisão de código e testes)

## Comandos Úteis (Exemplos por Stack)

### ⚠️ Importante: Ambientes Isolados com Parâmetros Obrigatórios

**Os comandos estão configurados para forçar ambientes isolados. O prefixo de isolamento é obrigatório, mas você pode adicionar mais parâmetros após ele.**

**Regra:** Mantenha o parâmetro de isolamento (ex: `-Dmaven.repo.local=./.m2/repository`), mas pode adicionar mais flags.

### Java / Kotlin (Maven)

```bash
# ✅ PERMITIDO - Isolamento obrigatório + parâmetros adicionais
mvn -Dmaven.repo.local=./.m2/repository clean test
mvn -Dmaven.repo.local=./.m2/repository -DskipTests=false jacoco:report
mvn -Dmaven.repo.local=./.m2/repository -Dorg.slf4j.simpleLogger.defaultLogLevel=debug clean test

# ❌ NÃO PERMITIDO - Sem isolamento
mvn clean test
```

### Java / Kotlin (Gradle)

```bash
# ✅ PERMITIDO - Isolamento obrigatório + flags adicionais
gradle --gradle-user-home ./.gradle test
gradle --gradle-user-home ./.gradle test --info
gradle --gradle-user-home ./.gradle clean build -x test

# ❌ NÃO PERMITIDO - Sem isolamento
gradle test
```

### JavaScript / TypeScript / Node.js

```bash
# npm ✅ PERMITIDO
npm install --no-save
npm install --no-save --verbose
npm test -- --coverage --verbose

# yarn ✅ PERMITIDO
yarn install --offline
yarn install --offline --verbose

# pnpm ✅ PERMITIDO
pnpm install
pnpm install --verbose

# npx ✅ PERMITIDO (qualquer parâmetro)
npx vitest run --coverage
npx eslint src/
```

### Python

```bash
# Criar venv (se não existir) ✅ PERMITIDO
python -m venv .venv
python -m venv .venv --upgrade-deps

# pip com isolamento ✅ PERMITIDO
python -m pip install -r requirements.txt -q
python -m pip install --target ./.venv/lib -q package-name
python -m pip install --target ./.venv/lib --upgrade package-name

# pytest e coverage ✅ PERMITIDO
python -m pytest --cov=src tests/ -v
python -m pytest --cov=src tests/ --cov-report=html
python -m coverage run -m pytest
python -m coverage report --skip-covered
```

### C# / .NET

```bash
# ✅ PERMITIDO
dotnet test
dotnet test /p:CollectCoverage=true /p:CoverageFormat=cobertura
dotnet test /p:CollectCoverage=true /p:Exclude=\"[*Tests]*\"
```

### Go

```bash
# ✅ PERMITIDO
go test -cover ./...
go test -cover ./... -v
go test -coverprofile=coverage.out ./... -timeout=10m
```

### Ruby / Rails

```bash
# ✅ PERMITIDO
bundle install --local
bundle install --local --no-deployment
bundle exec rspec --coverage
bundle exec rspec --coverage -f progress
```

### PHP

```bash
# ✅ PERMITIDO
composer install --no-dev
composer install --no-dev --optimize-autoloader
composer install --no-dev --classmap-authoritative
vendor/bin/phpunit --coverage-clover=coverage.xml
vendor/bin/phpunit --coverage-clover=coverage.xml -v
```

### Scala

```bash
# ✅ PERMITIDO
sbt clean coverage test coverageReport
sbt clean coverage test coverageReport -Dconfig=test
sbt "test -- -Dverbose=true"
```

## 🧹 Limpeza do Ambiente

Ao finalizar todas as correções, rode:

```bash
git status
```

Analise a saída e:

- Arquivos temporários, de build, cobertura ou cache que aparecerem → adicione ao `.gitignore`
- Arquivos staged que **não deveriam** estar → remova com `git restore --staged <arquivo>`
- Confirme que `.sonar_devin_auto_fix/` **não aparece** como staged

> ⚠️ **Não faça commit.** Deixe o repositório limpo e organizado para que o desenvolvedor humano revise e decida o que commitar.

### Limpeza de Ambientes Isolados (Opcional)

Se desejar remover ambientes isolados após conclusão:

```bash
# Python venv
rm -rf .venv

# Maven local repository (mantém src/pom.xml intacto)
rm -rf .m2

# Node modules (se necessário)
rm -rf node_modules .npm

# Outros caches
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
find . -type d -name "node_modules/.cache" -exec rm -rf {} + 2>/dev/null || true
```

**Importante:** Verifique que os ambientes isolados estão no `.gitignore`:

```bash
# Verificar se já estão no .gitignore
grep -E "^\.venv$|^\.m2$|^node_modules$|^__pycache__$" .gitignore

# Se não encontrar, adicionar:
echo ".venv" >> .gitignore
echo ".m2" >> .gitignore
echo "node_modules" >> .gitignore
echo ".pytest_cache" >> .gitignore
echo "__pycache__" >> .gitignore
```

## Notas Importantes

- 🎯 Trabalhe em iterações: uma issue por vez, com testes e documentação
- 📝 Mantenha o código limpo e alinhado ao padrão existente do projeto
- 🔍 Priorize a clareza e a manutenibilidade
- ⚠️ Sempre considere o impacto de cada mudança na lógica de negócio
- 🧹 **SEMPRE limpe o ambiente ao finalizar** — nenhum arquivo temporário deve ficar pendente
- ⚡ **Seja eficiente com tempo e tokens:** evite leituras desnecessárias, explorações excessivas e repetições. Leia apenas o que for estritamente necessário para corrigir a issue em questão. Prefira ações diretas e objetivas. Evite invocar ferramentas desnecessárias — use apenas o que a tarefa exige.
- 🚫 **Não implemente nada além do solicitado:** corrija exclusivamente as issues listadas no `sonarqube_issues.json`. Não refatore sem necessidade, não melhore, não adicione funcionalidades, não reorganize código que não esteja diretamente relacionado à issue.
- 🚫 **Não execute scripts de programação que requer validação humana antes de liberar:** ao tentar executar scripts é levado um prompt pro usuário decidir se pode ou não ser executado, o que remove sua autonomia e gera mais trabalho para o usuário.

## The Iron Law

```
NO COVERAGE EXCLUSIONS
```

Nenhuma exclusão de cobertura deve ser usada para contornar a falta de testes.

**No exceptions:**
- Não use `// NOSONAR`, `// no sonar`, `# noqa`, `# pragma: no cover`
- Não use decoradores como `@IgnoreCoverage`, `ExcludeFromCodeCoverage`, `@Suppress`
- Não use pragmas do compilador como `#pragma` para exclusões
- Se o arquivo já tiver exclusão, remova-a e implemente testes para o código
- Garanta 100% de cobertura das linhas modificadas

## Common Mistakes

| Erro | Consequência | Como evitar |
|------|-------------|-------------|
| Adicionar exclusões de cobertura | Código sem testes aprovado | Implemente testes para todas as linhas modificadas |
| Corrigir issues sem testes | Regressões não detectadas | Sempre adicionar testes unitários para cada correção |
| Modificar lógica de negócio sem necessidade | Risco de bugs | Limite-se ao escopo da issue do SonarQube |
| Não rodar linters após correção | Novas violações introduzidas | Execute linters da stack após cada correção |
| Não limpar ambiente ao final | Arquivos temporários no repo | Execute limpeza de ambiente ao finalizar |
| Printar valores de variáveis de ambiente | Violação de segurança | NUNCA leia ou print tokens, use variáveis diretamente nos comandos |

## Anti-Patterns

### ❌ "Este código é simples demais para precisar de teste"

Mesmo código simples pode ter bugs. TDD aplica-se a qualquer correção, não importa a complexidade.

### ❌ "Vou adicionar exclusão de cobertura só para este caso"

Exclusões de cobertura violam o princípio de qualidade. Se o código é complexo demais para testar, refatore-o.

### ❌ "O SonarQube está errado, não vou corrigir"

SonarQube pode ter falsos positivos, mas a maioria das issues é válida. Corrija e discuta casos legítimos com a equipe.

### ❌ "Vou corrigir tudo de uma vez sem testes"

Correções em massa sem testes aumentam drasticamente o risco de regressões. Corrija uma issue por vez com testes.

### ❌ "Não preciso rodar o scan local, o pipeline vai validar"

Validação local economiza tempo e evita rejeições no pipeline. Use o script `sonar-local-scan.sh`.

## Adaptations for this catalog

This skill follows the agent catalog standards:
- **Frontmatter** aligned to repo standard: `license: UNLICENSED`, `metadata.version`, `metadata.author`, tripartite `description` with explicit `Do NOT use for` clause
- **Language:** Portuguese (pt-BR) for content, English for technical terms
- **Branch policy:** follow `feature/{agent}-{YYYYMMDD}-{short-description}`
- **Git workflow:** branches created from `develop`, PR target is `develop` (not `main`)

## Origin

This skill was created following patterns from `obra/superpowers/skills/writing-skills` and adapted for SonarQube auto-fix workflows across multiple stacks.
