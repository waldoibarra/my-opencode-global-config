#!/bin/bash

_source_lib_functions() {
  local _script_dir
  _script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  source "$_script_dir/constants.sh"
  source "$_script_dir/lib/superpowers.sh"
  source "$_script_dir/lib/agent-teams-lite.sh"
}

_ensure_development_directory_exists() {
  mkdir -p "$AI_AGENTS_DIR"
}

_update_ai_agents() {
  update_agents_team_sdd_orchestration
  update_superpowers_agentic_skills_framework
}

main() {
  _source_lib_functions
  _ensure_development_directory_exists
  _update_ai_agents

  printf "\nDone updating. Restart OpenCode if it's open."
}

main
