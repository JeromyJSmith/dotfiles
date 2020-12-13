#!/usr/bin/env zsh
### zsh4humans: https://github.com/romkatv/zsh4humans
# usage: ln -fns $(pwd)/.zshrc-z4h.zshrc ~/.zshrc

### style
zstyle ':z4h:' auto-update 'ask'
zstyle ':z4h:' auto-update-days '28'
zstyle ':z4h:' prompt-position top
zstyle ':z4h:bindkey' keyboard 'mac'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:ssh:*' enable 'no'
zstyle ':zle:up-line-or-beginning-search' leave-cursor 'yes'
zstyle ':zle:down-line-or-beginning-search' leave-cursor 'yes'

### repos
# z4h install ohmyzsh/ohmyzsh || return

### initialization
z4h init || return

### exports
if command -v code-exploration &>/dev/null; then
  export EDITOR='code-exploration --wait'
elif command -v codium &>/dev/null; then
  export EDITOR='codium --wait'
elif command -v code &>/dev/null; then
  export EDITOR='code --wait'
elif command -v code-insiders &>/dev/null; then
  export EDITOR='code-insiders --wait'
else
  export EDITOR='vim'
fi
TTY=$(tty)
export GPG_TTY=$TTY
export SSH_KEY_PATH=$HOME/.ssh/id_rsa_$USER
if [[ $(uname) = 'Linux' ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

### PATH extensions: array items must be unquoted and $path must be lowercase
path=($path $HOME/.local/bin $HOME/.poetry/bin)

### sources: z4h source /path/to/script

### keybindings
z4h bindkey undo Ctrl+/                # undo last command line change
z4h bindkey redo Alt+/                 # redo last undone command line change
z4h bindkey z4h-cd-back Shift+Left     # cd into previous directory
z4h bindkey z4h-cd-forward Shift+Right # cd into next directory
z4h bindkey z4h-cd-up Shift+Up         # cd into parent directory
z4h bindkey z4h-cd-down Shift+Down     # cd into a child directory

### autoload functions
autoload -Uz zmv

### additional functions and completions
md() {
  [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" || return
}
compdef _directories md

### aliases
alias dc='docker-compose'
alias python='python3'
alias tree='tree -a -I .git'

### Zsh options: http://zsh.sourceforge.net/Doc/Release/Options.html
setopt glob_dots    # no special treatment for file names with a leading dot
setopt no_auto_menu # require an extra TAB press to open the completion menu