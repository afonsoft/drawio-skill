#!/usr/bin/env bash
set -euo pipefail

# Download de issues do SonarQube com detecção automática de edição
# ⚠️ SEGURANÇA: Este script usa variáveis de ambiente diretamente no bash.
# NUNCA inspecione ou print o valor de $SONAR_TOKEN ou outras variáveis de token.
# O bash expande as variáveis automaticamente - você não precisa (e não deve) ler seus valores.

PROJECT_NAME="${1:-}"
ISSUES_CSV="${2:-}"
NEW_CODE_ONLY="${3:-false}"

error_exit() {
  echo "[ERRO] $1" >&2
  exit 1
}

[ -n "$PROJECT_NAME" ] || error_exit "PROJECT_NAME não fornecido."

# Detectar edição e construir URL dinâmica
if [ -n "${SONARQUBE_CUSTOM_URL:-}" ]; then
  SONAR_BASE_URL="$SONARQUBE_CUSTOM_URL"
  SONAR_TOKEN="${SONARQUBE_CUSTOM_TOKEN:-}"
  SONAR_EDITION="${SONARQUBE_CUSTOM_EDITION:-open}"
elif [ -n "${SONARQUBE_ENTERPRISE_TOKEN:-}" ]; then
  [ -n "${SONARQUBE_ENTERPRISE_URL:-}" ] || error_exit "SONARQUBE_ENTERPRISE_URL não configurada."
  SONAR_BASE_URL="$SONARQUBE_ENTERPRISE_URL"
  SONAR_TOKEN="$SONARQUBE_ENTERPRISE_TOKEN"
  SONAR_EDITION="enterprise"
elif [ -n "${SONARQUBE_OPEN_TOKEN:-}" ] || [ -n "${SONAR_TK:-}" ]; then
  [ -n "${SONARQUBE_OPEN_URL:-}" ] || error_exit "SONARQUBE_OPEN_URL não configurada."
  SONAR_BASE_URL="$SONARQUBE_OPEN_URL"
  SONAR_TOKEN="${SONARQUBE_OPEN_TOKEN:-$SONAR_TK}"
  SONAR_EDITION="open"
else
  error_exit "Nenhuma configuração de SonarQube encontrada. Defina SONARQUBE_CUSTOM_URL, ou SONARQUBE_ENTERPRISE_TOKEN + SONARQUBE_ENTERPRISE_URL, ou SONARQUBE_OPEN_TOKEN/SONAR_TK + SONARQUBE_OPEN_URL."
fi

# Detectar branch para edições Enterprise/Custom enterprise
if [ "$SONAR_EDITION" = "enterprise" ]; then
  CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "")
  if [ -n "$CURRENT_BRANCH" ]; then
    BRANCH_PARAM="&branch=$CURRENT_BRANCH"
  else
    BRANCH_PARAM=""
  fi
else
  BRANCH_PARAM=""
fi

# Construir URL da API
if [ -n "$ISSUES_CSV" ]; then
  # Baixar issues específicas por CSV
  IFS=',' read -ra ISSUE_IDS <<< "$ISSUES_CSV"
  ISSUES_PARAM=""
  for id in "${ISSUE_IDS[@]}"; do
    ISSUES_PARAM="${ISSUES_PARAM}&issues=${id}"
  done
  API_URL="${SONAR_BASE_URL}/api/issues/search?resolved=false&components=${PROJECT_NAME}${ISSUES_PARAM}${BRANCH_PARAM}"
else
  # Baixar todas as issues não resolvidas
  API_URL="${SONAR_BASE_URL}/api/issues/search?resolved=false&components=${PROJECT_NAME}"

  if [ "$NEW_CODE_ONLY" = "true" ]; then
    API_URL="${API_URL}&inNewCodePeriod=true"
  fi

  API_URL="${API_URL}${BRANCH_PARAM}"
fi

# Baixar issues
AUTH_HEADER=""
if [ -n "$SONAR_TOKEN" ]; then
  AUTH_HEADER="Authorization: Bearer $SONAR_TOKEN"
fi

if [ -n "$AUTH_HEADER" ]; then
  curl -fs "$API_URL" -H "$AUTH_HEADER"
else
  curl -fs "$API_URL"
fi
