bindkey -v
bindkey 'jk' vi-cmd-mode

export CLICOLOR=1
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore --follow --exclude "{.git/*,node_modules/*}"'
export FZF_CTRL_T_COMMAND='fd --type d --no-ignore --follow --exclude "{.git,node_modules}"'
export LS_COLORS=exfxcxdxbxegedabagacad # set default LS_COLORS for use by fd
export PATH="/opt/homebrew/bin:$PATH"
export GOPATH="/Users/anand/.go"

# Add extra, user-specified completions
fpath+=~/.zfunc

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'
# Add homebrew zsh completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# enable the default zsh completions!
autoload -Uz compinit && compinit
# enable bash completions
autoload -U bashcompinit
bashcompinit

NEWLINE=$'\n'
setopt PROMPT_SUBST

export PS1='%F{green}%n%F{reset_color}@%F{yellow}%m%F{reset_color}:%F{blue}%~ %F{magenta}${vcs_info_msg_0_}${NEWLINE}%F{reset_color}$ '

+# History configuration for sharing across Ghostty tabs
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history   # Append history incrementally (after each command)
setopt share_history        # Share history between all zsh sessions
setopt append_history       # Append to history file instead of overwriting
setopt extended_history     # Include timestamps in history
setopt hist_ignore_dups     # Don't record duplicate entries
setopt hist_ignore_space    # Don't record commands starting with space
setopt interactivecomments

alias vi="/opt/homebrew/bin/nvim"
alias py="/opt/homebrew/bin/python3"
alias rg="rg --colors 'path:fg:blue' --colors 'match:fg:red'"
alias gs="git status"
alias claude="/Users/anand/.claude/local/claude"

function json_diff() {
        vi -d <(jq -S . $1) <(jq -S . $2)
}

function jqi() {
        `echo '' | fzf --disabled --print-query --preview-window 'down:90%' --preview 'jq --color-output {q} < $1'`
}

# Play two videos side by side in mpv
function mpvlr() {
        if [ $# -ne 2 ]; then
          echo "Usage: mpvlr <left_video> <right_video>"
          return 1
        fi

        if [ ! -f "$1" ]; then
          echo "Error: Left video file '$1' not found"
          return 1
        fi

        if [ ! -f "$2" ]; then
          echo "Error: Right video file '$2' not found"
          return 1
        fi

        mpv "$1" --external-file="$2" --lavfi-complex='[vid1] [vid2] hstack [vo]'
  }

fpath=(~/.zsh $fpath)
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export MANPAGER='nvim +Man!'

export PATH="$PATH:/Users/anand/.modular/bin"
export PATH="/Users/anand/.claude/local:$PATH"
