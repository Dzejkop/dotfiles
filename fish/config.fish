set -x EDITOR nvim
set -x RUSTC_WRAPPER sccache

alias ls lsd
alias gp 'git pull'

starship init fish | source
