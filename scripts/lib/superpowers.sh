_install_or_update_superpowers_repo() {
  if [ -d "$_repo_dir" ]; then
    cd "$_repo_dir" || { echo "Failed to cd into $_repo_dir"; exit 1; }
    git pull
  else
    git clone https://github.com/obra/$_repo_name.git "$_repo_dir"
  fi
}

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
  local -r _repo_dir="$AI_AGENTS_DIR/$_repo_name"

  printf "\nUpdating the repo: %s" "$_repo_dir"

  _install_or_update_superpowers_repo
  _ensure_global_plugins_and_skills_directories
  _remove_old_plugin_and_skills
  _copy_updated_plugin_and_skills

  echo "Done updating $_repo_name."
}
