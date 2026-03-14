#!/bin/bash

repo_dir="$DEVELOPMENT_DIR/superpowers"

install_or_update_superpowers_repo() {
  if [ -d $repo_dir ]; then
    cd $repo_dir
    git pull
  else
    git clone https://github.com/obra/superpowers.git $repo_dir
  fi
}

ensure_global_plugins_and_skills_directories() {
  mkdir -p "$GLOBAL_CONFIG_DIR/plugins" "$GLOBAL_CONFIG_DIR/skills"
}

remove_old_plugin_and_skills() {
  rm -f "$GLOBAL_CONFIG_DIR/plugins/superpowers.js"
  rm -rf "$GLOBAL_CONFIG_DIR/skills/superpowers"
}

copy_updated_plugin_and_skills() {
  cp "$repo_dir/.opencode/plugins/superpowers.js" "$GLOBAL_CONFIG_DIR/plugins/superpowers.js"
  cp -r "$repo_dir/skills" "$GLOBAL_CONFIG_DIR/skills/superpowers"
}

update_superpowers_agentic_skills_framework() {
  echo "Updating the repo $repo_dir to update plugin and skills."
  install_or_update_superpowers_repo
  ensure_global_plugins_and_skills_directories
  remove_old_plugin_and_skills
  copy_updated_plugin_and_skills
  echo "Done updating superpowers plugin and skills."
}
