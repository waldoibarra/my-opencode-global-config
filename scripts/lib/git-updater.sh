_get_current_commit() {
  cd_or_exit "$_repo_dir"
  git rev-parse HEAD
}

_pull_repository() {
  local _previous_commit
  local _current_commit

  _previous_commit=$(_get_current_commit)
  cd_or_exit "$_repo_dir"
  git pull
  _current_commit=$(_get_current_commit)

  _has_new_commits
}

_has_new_commits() {
  [ "$_previous_commit" != "$_current_commit" ]
}

_clone_repository() {
  git clone "$_repo_url" "$_repo_dir"
}

git_pull_or_clone_and_check_for_updates() {
  local -r _repo_url="$1"
  local -r _repo_dir="$2"

  if [ -d "$_repo_dir" ]; then
    _pull_repository
    return $?
  fi

  _clone_repository
}
