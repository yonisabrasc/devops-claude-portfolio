#!/bin/bash
# PostToolUse : formate un fichier .tf après chaque Edit/Write.
# Le chemin arrive en JSON sur stdin (tool_input.file_path), pas en variable d'environnement.
command -v jq >/dev/null 2>&1 || exit 0
command -v terraform >/dev/null 2>&1 || exit 0
FILE=$(jq -r '.tool_input.file_path // empty')
[ -z "$FILE" ] && exit 0
case "$FILE" in
  *.tf) terraform fmt "$FILE" >/dev/null 2>&1 ;;
esac
exit 0
