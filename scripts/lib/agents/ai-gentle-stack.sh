_check_for_new_versions_and_install() {
  brew upgrade gentle-ai
}

_refresh_managed_assets_to_current_version() {
  gentle-ai sync --agent opencode
}

_migrate_agents_json_to_markdown() {
  local -r _project_root_dir=$(dirname "$SCRIPTS_DIR")
  local -r _migration_script_dir="$SCRIPTS_DIR/lib/agents/migrate-agents"

  cd_or_exit "$_migration_script_dir"
  npm ci &> /dev/null || { echo "❌ Failed to install migration JS dependencies."; exit 1; }
  npm start -- "$_project_root_dir" || { echo "❌ Failed to migrate agents."; exit 1; }
}

update_gentleman_ai_ecosystem() {
  local -r _tool_name="gentle-ai"

  print_separator "Updating $_tool_name"

  _check_for_new_versions_and_install
  _refresh_managed_assets_to_current_version
  _migrate_agents_json_to_markdown

  print_separator "Done updating $_tool_name"
}
