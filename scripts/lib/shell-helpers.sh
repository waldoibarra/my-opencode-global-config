cd_or_exit() {
  cd "$1" || { echo "❌ Failed to cd into $1"; exit 1; }
}
