cd_or_exit() {
  cd "$1" || { echo "❌ Failed to cd into $1"; return 1; }
}
