#!/bin/bash

_source_lib_functions() {
  local _script_dir
  _script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  source "$_script_dir/lib/constants.sh"
  source "$_script_dir/lib/shell-helpers.sh"
  source "$_script_dir/lib/git-updater.sh"
  source "$_script_dir/lib/agents/superpowers.sh"
  source "$_script_dir/lib/agents/agent-teams.sh"
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

  printf "\n✅ Done updating. Restart OpenCode if it's open.\n"
}

main
