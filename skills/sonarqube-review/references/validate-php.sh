#!/usr/bin/env bash
set -euo pipefail

# Script de validação para PHP
# Executa PHPStan, PHP CS Fixer e phpunit

echo "Validando PHP..."

# PHPStan
vendor/bin/phpstan analyse

# PHP CS Fixer (formatter)
vendor/bin/php-cs-fixer fix --dry-run

# phpunit (testes com cobertura)
vendor/bin/phpunit --coverage-clover=coverage.xml

echo "Validação PHP concluída."
