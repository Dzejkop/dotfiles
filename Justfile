init:
  git submodule update --init --recursive
  
stow:
  stow -v home

sim:
  stow -nv home

unstow:
  stow -v -D home

