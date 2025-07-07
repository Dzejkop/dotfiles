ap() {
  profiles=$(aws configure list-profiles)

  selected=$(printf "%s\n" "${profiles[@]}" |
    fzf --height 10 --reverse --prompt="AWS profile> ")

  if [[ -n "$selected" ]]; then
    echo "Logging into AWS SSO profile: $selected"
    aws sso login --profile "$selected"
  else
    echo "No profile selected." >&2
    exit 1
  fi
}
