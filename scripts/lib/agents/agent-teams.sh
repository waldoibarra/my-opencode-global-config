_run_setup_script_to_update_agents_and_skills() {
  cd_or_exit "$_repo_dir"
  ./scripts/setup.sh --agent opencode --opencode-mode multi
}

_migrate_agents_json_to_markdown() {
  local -r _project_root_dir=$(dirname "$SCRIPTS_DIR")
  local -r _migration_script_dir="$SCRIPTS_DIR/lib/agents/migrate-agents"

  cd_or_exit "$_migration_script_dir"
  npm ci &> /dev/null || { echo "❌ Failed to install migration JS dependencies."; exit 1; }
  npm start -- "$_project_root_dir" || { echo "❌ Failed to migrate agents."; exit 1; }
}

update_agents_team_sdd_orchestration() {
  local -r _repo_name="agent-teams-lite"
  local -r _repo_url="$GITHUB_URL/gentleman-programming/$_repo_name.git"
  local -r _repo_dir="$AI_AGENTS_DIR/$_repo_name"

  printf "\nUpdating the repo: %s\n" "$_repo_dir"

  if ! git_pull_or_clone_and_check_for_updates "$_repo_url" "$_repo_dir"; then
    printf "⚠️ No new commits, skipping update.\n"
    return
  fi

  _run_setup_script_to_update_agents_and_skills
  _migrate_agents_json_to_markdown

  echo "✅ Done updating $_repo_name."
}
