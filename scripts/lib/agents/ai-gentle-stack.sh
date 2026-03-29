_check_for_new_versions_and_install() {
  gentle-ai update
  gentle-ai upgrade
}

_refresh_managed_assets_to_current_version() {
  gentle-ai sync --agent opencode
}

update_gentleman_ai_ecosystem() {
  local -r _tool_name="gentle-ai"

  print_separator "Updating CLI: $_tool_name"

  _check_for_new_versions_and_install
  _refresh_managed_assets_to_current_version

  print_separator "Done updating CLI: $_tool_name"
}
