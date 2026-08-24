#!/usr/bin/env bash
set -euo pipefail

# Script de validação para Python
# Executa Pylint, Flake8, Black e pytest

echo "Validando Python..."

# Pylint
python -m pylint src/

# Flake8
python -m flake8 src/

# Black (formatter)
python -m black --check src/

# pytest (testes com cobertura)
python -m pytest --cov=src tests/ -v

echo "Validação Python concluída."
