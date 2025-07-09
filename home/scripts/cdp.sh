cr() {
  # Check if repository name is provided
  if [ -z "$1" ]; then
    echo "Usage: $0 <repository>"
    exit 1
  fi

  # Extract the owner and repo name
  local repo
  local owner
  repo=$1
  owner=$(echo "$repo" | cut -d'/' -f1)

  # Change dir to root (~/Projects)
  cd ~/Projects || exit

  # Create the directory structure and clone the repo
  mkdir -p "$owner"
  cd "$owner" || exit
  gh repo clone "$repo"

  gh repo clone "$repo"
  local repo_name
  repo_name=$(echo "$repo" | cut -d'/' -f2)
  cd "$repo_name" || exit
}

proj() {
  cd ~/Projects/ || return
}

cdp() {
  local base=~/Projects
  # find all 2-level-deep directories, strip the prefix
  local choice
  choice=$(find "$base" -mindepth 2 -maxdepth 2 -type d |
    sed "s|^$base/||" |
    fzf --height 40% --reverse --prompt="Projects> ")

  if [[ -n $choice ]]; then
    cd "$base/$choice" || return

    if [[ -n $ZELLIJ_SESSION_NAME ]]; then
      zellij action rename-tab "$choice"
    fi
  fi
}
