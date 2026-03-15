_install_or_update_agent_teams_lite_repo() {
  if [ -d "$_repo_dir" ]; then
    cd "$_repo_dir" || { echo "Failed to cd into $_repo_dir"; exit 1; }
    git pull
  else
    git clone https://github.com/gentleman-programming/$_repo_name.git "$_repo_dir"
  fi
}

_run_setup_script_to_update_agents_and_skills() {
  cd "$_repo_dir" || { echo "Failed to cd into $_repo_dir"; exit 1; }
  ./scripts/setup.sh --agent opencode --opencode-mode multi
}

update_agents_team_sdd_orchestration() {
  local -r _repo_name="agent-teams-lite"
  local -r _repo_dir="$AI_AGENTS_DIR/$_repo_name"

  printf "\nUpdating the repo: %s" "$_repo_dir"

  _install_or_update_agent_teams_lite_repo
  _run_setup_script_to_update_agents_and_skills
  # _extract_agents_from_json_to_markdown

  echo "Done updating $_repo_name."
}
