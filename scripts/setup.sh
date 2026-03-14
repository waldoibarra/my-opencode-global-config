#!/bin/bash

source_lib_functions() {
  # Get the directory of the current script, resolving symlinks if possible.
  script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

  # Fallback for systems without 'cd -P' or 'readlink -f' (less robust but works in most cases).
  if [ -z "$script_dir" ]; then
    script_dir="$(dirname "$(realpath "$0")")"
  fi

  source "$script_dir/constants.sh"
  source "$script_dir/lib/superpowers.sh"
}

ensure_development_directory_exists() {
  mkdir -p $DEVELOPMENT_DIR
}

update_

main() {
  source_lib_functions
  ensure_development_directory_exists
  # update_agents_team_sdd_orchestration
  update_superpowers_agentic_skills_framework

  echo "Done. Restart OpenCode if it's open."
}

main
