init:
  git submodule update --init --recursive
  
stow:
  stow -v home

unstow:
  stow -v -D home

