_ensure_global_plugins_and_skills_directories() {
  mkdir -p "$GLOBAL_CONFIG_DIR/plugins" "$GLOBAL_CONFIG_DIR/skills"
}

_remove_old_plugin_and_skills() {
  rm -f "$GLOBAL_CONFIG_DIR/plugins/superpowers.js"
  rm -rf "$GLOBAL_CONFIG_DIR/skills/$_repo_name"
}

_copy_updated_plugin_and_skills() {
  cp "$_repo_dir/.opencode/plugins/superpowers.js" "$GLOBAL_CONFIG_DIR/plugins/superpowers.js"
  cp -r "$_repo_dir/skills" "$GLOBAL_CONFIG_DIR/skills/$_repo_name"
}

update_superpowers_agentic_skills_framework() {
  local -r _repo_name="superpowers"
  local -r _repo_url="$GITHUB_URL/obra/$_repo_name.git"
  local -r _repo_dir="$AI_AGENTS_DIR/$_repo_name"

  print_separator "Updating repo: $_repo_name"

  if ! git_pull_or_clone_and_check_for_updates "$_repo_url" "$_repo_dir"; then
    print_separator "No new commits, skipping $_repo_name update"
    return
  fi

  _ensure_global_plugins_and_skills_directories
  _remove_old_plugin_and_skills
  _copy_updated_plugin_and_skills

  print_separator "Done updating repo: $_repo_name"
}
