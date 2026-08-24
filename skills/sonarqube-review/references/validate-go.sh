#!/usr/bin/env bash
set -euo pipefail

# Script de validação para Go
# Executa golangci-lint, gofmt e go test

echo "Validando Go..."

# golangci-lint
golangci-lint run

# gofmt (formatter)
gofmt -l .

# go test (testes com cobertura)
go test -cover ./...

echo "Validação Go concluída."
