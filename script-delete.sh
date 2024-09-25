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
  find . -type d -empty | grep -vE "$(printf "|%s" "${IGNORED_DIRS[@]}")"
}

# Função para excluir a pasta após confirmação
delete_dir() {
  for dir in $(find_empty_dirs); do
    echo "Pasta vazia encontrada: $dir"
    read -p "Deseja excluir esta pasta? (s/n): " confirm
    if [[ "$confirm" == "s" || "$confirm" == "S" ]]; then
      rmdir "$dir"
      echo "Pasta $dir excluída!"
    else
      echo "Pasta $dir não foi excluída."
    fi
  done
}

# Rodar o script
delete_dir
