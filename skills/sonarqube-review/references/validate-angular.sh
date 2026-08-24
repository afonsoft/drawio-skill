#!/usr/bin/env bash
set -euo pipefail

# Script de validação para Angular
# Executa linting, testes e formatação para projetos Angular

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

echo "🔍 Validando projeto Angular..."

# Verificar se é um projeto Angular
if [ ! -f "angular.json" ] && [ ! -f "angular-cli.json" ]; then
    echo "❌ Erro: Não é um projeto Angular (angular.json não encontrado)"
    exit 1
fi

# Linting
echo "🔧 Executando ng lint..."
if command -v ng &> /dev/null; then
    ng lint || {
        echo "❌ Erro: ng lint falhou"
        exit 1
    }
else
    echo "⚠️  ng não encontrado, tentando eslint..."
    npx eslint src/ || {
        echo "❌ Erro: eslint falhou"
        exit 1
    }
fi

# Formatação com Prettier
echo "✨ Formatando código com Prettier..."
npx prettier --write src/ || {
    echo "⚠️  Aviso: Prettier falhou, continuando..."
}

# Formatação com ESLint --fix
echo "✨ Formatando código com ESLint..."
npx eslint --fix src/ || {
    echo "⚠️  Aviso: ESLint --fix falhou, continuando..."
}

# Testes com cobertura
echo "🧪 Executando testes com cobertura..."
ng test --code-coverage --watch=false || {
    echo "❌ Erro: ng test falhou"
    exit 1
}

# Build para validação
echo "🏗️  Executando build para validação..."
ng build --configuration=production || {
    echo "❌ Erro: ng build falhou"
    exit 1
}

echo "✅ Validação Angular concluída com sucesso"
