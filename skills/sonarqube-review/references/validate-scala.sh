#!/usr/bin/env bash
set -euo pipefail

# Script de validação para Scala
# Executa Scalastyle, Scapegoat e sbt test

echo "Validando Scala..."

# Scalastyle
sbt scalastyle

# Scapegoat
sbt scapegoat

# sbt test (testes com cobertura)
sbt clean coverage test coverageReport

echo "Validação Scala concluída."
