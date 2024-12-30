init:
  git submodule update --init --recursive
  
stow:
  stow -v home

sim:
  stow -nv home

unstow:
  stow -v -D home

mac-install:
  brew install jesseduffield/lazygit/lazygit
  brew install zoxide fzf
  brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font

