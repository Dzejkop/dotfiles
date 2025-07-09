init:
  git submodule update --init --recursive
  
stow:
  stow -t "$HOME" -v home

sim:
  stow -t "$HOME" -nv home

unstow:
  stow -t "$HOME" -v -D home

mac-install:
  brew install jesseduffield/lazygit/lazygit
  brew install zoxide fzf
  brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font

