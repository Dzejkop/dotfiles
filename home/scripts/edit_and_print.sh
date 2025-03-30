#!/bin/bash

# Create a temporary file for editing
tmpfile=$(mktemp /tmp/editor_buffer.XXXXXX)

# Ensure the temporary file is removed on script exit
trap 'rm -f "$tmpfile"' EXIT

# Open the temporary file in your preferred editor
"$EDITOR" "$tmpfile"

# Output the contents of the edited file
echo "=== Buffer Contents ==="
cat "$tmpfile"
