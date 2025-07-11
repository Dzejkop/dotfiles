# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf docker docker-compose kubectl rust mix vi-mode)

source $ZSH/oh-my-zsh.sh

# Automatically source all scripts in $HOME/scripts
for script in "$HOME/scripts"/*.sh; do
  [[ -r "$script" ]] && source "$script"
done

# checks whether a command exists using -v, -V or which
exists() {
    [[ $# -eq 0 ]] && {
        echo "Usage: exists command_name"
        return 2
    }

    typeset command_name="$1"
    typeset command_exists=false

    # Try command -v first (preferred method)
    if command -v "$command_name" >/dev/null 2>&1; then
        command_exists=true
    fi

    # Try with -V
    if command -V "$command_name" > /dev/null 2>&1; then
      command_exists=true
    fi

    # Try with which
    if which "$command_name" >/dev/null 2>&1; then
        command_exists=true
    fi

    [[ "$command_exists" = false ]] && {
        echo "✗ '$command_name' not found"
        return 1
    }

    return 0
}

alias_if_exists() {
  if exists $1; then
    alias $2=$1
  fi
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export NARGO_HOME="$HOME/.nargo"
export PATH="$PATH:$NARGO_HOME/bin"

export PATH="${HOME}/.bb:${PATH}"

export PATH="$HOME/.local/bin:$PATH"

# Add scripts to PATH
export PATH=$HOME/bin:$PATH

alias_if_exists nvim vim
alias_if_exists nvim vi
alias_if_exists lazygit lg
alias_if_exists lazydocker ld
alias_if_exists lsd ls

export EDITOR=lvim

alias cvim='NVIM_APPNAME=cvim nvim'

if ls "$HOME/.wasmer" >/dev/null 2>&1; then
  # Wasmer
  export WASMER_DIR="$HOME/.wasmer"
  [ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
fi


if exists zoxide; then
  # Initialize zoxide
  eval "$(zoxide init zsh)"

  alias cd=z 
fi

if exists zellij; then
  alias za="zellij action"
fi

if exists yazi; then
  # Yazi cwd capable wrapper
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

if exists mise; then
  # Activate mise
  eval "$(~/.local/bin/mise activate zsh)"
fi

