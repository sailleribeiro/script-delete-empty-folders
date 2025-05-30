#!/bin/bash

# Lista de pastas que devem ser ignoradas
IGNORED_DIRS=(
  "./.git"
  "./node_modules"
  "./dist"
  "./build"
)

# Função para encontrar e listar pastas vazias, ignorando as cruciais
find_empty_dirs() {
  find . -type d -empty | grep -vE "$(printf "%s|" "${IGNORED_DIRS[@]}" | sed 's/|$//')"
}

# Função principal
main() {
  empty_dirs=$(find_empty_dirs)

  if [[ -z "$empty_dirs" ]]; then
    echo "Nenhuma pasta vazia encontrada."
    exit 0
  fi

  echo "Pastas vazias encontradas:"
  echo "$empty_dirs"
  
  read -p "Deseja excluir todas estas pastas? (s/n): " confirm
  if [[ "$confirm" == "s" || "$confirm" == "S" ]]; then
    while IFS= read -r dir; do
      rmdir "$dir" && echo "Pasta $dir excluída!"
    done <<< "$empty_dirs"
  else
    echo "Nenhuma pasta foi excluída."
  fi
}

# Rodar o script
main
