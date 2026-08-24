#!/usr/bin/env bash
set -euo pipefail

# Script de validação para Ruby
# Executa RuboCop, Rufo e rspec

echo "Validando Ruby..."

# RuboCop
bundle exec rubocop

# Rufo (formatter)
bundle exec rufo --check .

# rspec (testes com cobertura)
bundle exec rspec --coverage

echo "Validação Ruby concluída."
