set -x EDITOR nvim
set -x RUSTC_WRAPPER sccache
alias ls lsd

# Rust & Cargo aliases
alias ctaaf "cargo test --all --all-features"
alias ccaaf "cargo check --all --all-features"
alias ccmd "env RUSTFLAGS=\"-Dmissing_docs\" cargo check --all"

starship init fish | source
