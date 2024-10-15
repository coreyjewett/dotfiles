# convert stdin or argv to a URI slug
slugify() {
  local input

  if [ $# -eq 0 ]; then
    # Check if there is input on stdin
    if [ -t 0 ]; then
      echo "No input provided" >&2
      return 1
    else
      # Read input from stdin
      read -r input
    fi
  else
    # Read input from arguments
    input="$*"
  fi

  # Convert to lowercase, replace spaces and special characters with hyphens, and remove leading/trailing hyphens
  echo "$input" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-9]/-/g' -e 's/--*/-/g' -e 's/^-//' -e 's/-$//';
}
