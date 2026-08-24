#!/usr/bin/env bash
set -euo pipefail

# Script de validação para C#/.NET
# Executa Roslyn Analyzers, dotnet format e dotnet test

echo "Validando C#/.NET..."

# Roslyn Analyzers
dotnet build /p:RunAnalyzersDuringBuild=true

# dotnet format (formatter)
dotnet format --verify-no-changes

# dotnet test (testes com cobertura)
dotnet test /p:CollectCoverage=true /p:CoverageFormat=cobertura

echo "Validação C#/.NET concluída."
