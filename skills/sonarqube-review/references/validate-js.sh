#!/usr/bin/env bash
set -euo pipefail

# Script de validação para JavaScript/TypeScript
# Executa ESLint, Prettier e Vitest/Jest

echo "Validando JavaScript/TypeScript..."

# ESLint
npx eslint src/

# Prettier (formatter)
npx prettier --check src/

# Vitest/Jest (testes com cobertura)
if grep -q "vitest" package.json; then
  npx vitest run --coverage
elif grep -q "jest" package.json; then
  npm test -- --coverage
else
  npm test
fi

echo "Validação JavaScript/TypeScript concluída."
