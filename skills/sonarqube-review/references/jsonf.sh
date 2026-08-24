#!/usr/bin/env bash
set -euo pipefail

# Script para formatar JSON com indentação
# Uso: jsonf <arquivo.json>

jsonf(){
  f=$1
  i=0
  s=false
  e=false
  n=false
  
  while IFS= read -r -n1 c; do
    if $s; then
      if $e; then
        printf '%s' "$c"
        e=false
      elif [[ $c == '\\' ]]; then
        printf '%s' "$c"
        e=true
      elif [[ $c == '"' ]]; then
        printf '%s' "$c"
        s=false
      else
        printf '%s' "$c"
      fi
    else
      case $c in
        "{"|"[")
          printf '%s' "$c"
          echo
          ((i+=4))
          printf '%*s' $i ''
          n=false
          ;;
        "}"|"]")
          echo
          ((i-=4))
          printf '%*s' $i ''
          printf '%s' "$c"
          n=false
          ;;
        ",")
          printf '%s\n' "$c"
          printf '%*s' $i ''
          n=false
          ;;
        ":")
          printf '%s' ": "
          n=false
          ;;
        '"')
          printf '%s' "$c"
          s=true
          ;;
        *)
          if [[ ! $c =~ [[:space:]] ]]; then
            printf '%s' "$c"
          fi
          ;;
      esac
    fi
  done < "$f"
}

jsonf "$1" | sed '/^[[:space:]]\+$/d'
