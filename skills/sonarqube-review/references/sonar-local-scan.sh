#!/usr/bin/env bash
set -euo pipefail

# Script para executar SonarQube localmente e revalidar correções
# Uso: bash sonar-local-scan.sh [project-key]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Detectar project key
PROJECT_KEY="${1:-}"
if [ -z "$PROJECT_KEY" ]; then
    # Tentar extrair do sonar-project.properties
    if [ -f "$PROJECT_ROOT/sonar-project.properties" ]; then
        PROJECT_KEY=$(grep "^sonar.projectKey=" "$PROJECT_ROOT/sonar-project.properties" | cut -d'=' -f2)
    fi
    # Se ainda não tiver, usar nome da pasta
    if [ -z "$PROJECT_KEY" ]; then
        PROJECT_KEY=$(basename "$PROJECT_ROOT")
    fi
fi

echo "🔍 Executando SonarQube scan local para projeto: $PROJECT_KEY"
echo "📂 Diretório do projeto: $PROJECT_ROOT"

# Verificar se sonar-scanner está instalado
if ! command -v sonar-scanner &> /dev/null; then
    echo "❌ Erro: sonar-scanner não está instalado"
    echo "📖 Instale em: https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/scanners/sonarscanner/"
    echo "   Ou rode ./install-skill-tools.sh --sonar neste repositório."
    exit 1
fi

# Criar sonar-project.properties se não existir
if [ ! -f "$PROJECT_ROOT/sonar-project.properties" ]; then
    echo "📝 Criando sonar-project.properties..."
    cat > "$PROJECT_ROOT/sonar-project.properties" << EOF
sonar.projectKey=$PROJECT_KEY
sonar.sources=src
sonar.tests=tests
sonar.exclusions=**/node_modules/**,**/dist/**,**/bin/**,**/obj/**,**/target/**,**/build/**
sonar.coverage.exclusions=**/*Tests.cs,**/Program.cs,**/Startup.cs,**/AssemblyInfo.cs
EOF
fi

# Detectar stack e configurar relatórios de cobertura
if [ -f "$PROJECT_ROOT/package.json" ]; then
    # JavaScript/TypeScript/Angular
    echo "sonar.javascript.lcov.reportPaths=coverage/lcov.info" >> "$PROJECT_ROOT/sonar-project.properties"
    echo "sonar.typescript.lcov.reportPaths=coverage/lcov.info" >> "$PROJECT_ROOT/sonar-project.properties"
elif [ -f "$PROJECT_ROOT/pom.xml" ] || [ -f "$PROJECT_ROOT/build.gradle" ]; then
    # Java/Kotlin
    echo "sonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml" >> "$PROJECT_ROOT/sonar-project.properties"
elif [ -f "$PROJECT_ROOT/.csproj" ] || [ -f "$PROJECT_ROOT/*.sln" ]; then
    # C# .NET
    echo "sonar.cs.vscoveragexml.reportPaths=coverage.xml" >> "$PROJECT_ROOT/sonar-project.properties"
fi

# Executar scan
echo "🚀 Executando sonar-scanner..."
cd "$PROJECT_ROOT"
sonar-scanner \
    -Dsonar.projectKey="$PROJECT_KEY" \
    -Dsonar.host.url="http://localhost:9000" \
    -Dsonar.login="${SONAR_TOKEN:-admin}"

echo "✅ Scan concluído"
echo "🌐 Acesse: http://localhost:9000/dashboard?id=$PROJECT_KEY"
