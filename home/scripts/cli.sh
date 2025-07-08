e() {
  # Create a temporary file for editing
  tmpfile=$(mktemp /tmp/editor_buffer.XXXXXX.sh)

  # Ensure the temporary file is removed on script exit
  trap 'rm -f "$tmpfile"' EXIT

  # Open the temporary file in your preferred editor
  "$EDITOR" "$tmpfile"

  # shellcheck source=/dev/null
  source "$tmpfile"
}
