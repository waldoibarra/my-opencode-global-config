_run_setup_script_to_update_agents_and_skills() {
  cd_or_exit "$_repo_dir"
  ./scripts/setup.sh --agent opencode --opencode-mode multi
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

  echo "✅ Done updating $_repo_name."
}
