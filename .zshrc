bindkey -v
bindkey 'jk' vi-cmd-mode

export CLICOLOR=1
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore --follow --exclude "{.git/*,node_modules/*}"'
export FZF_CTRL_T_COMMAND='fd --type d --no-ignore --follow --exclude "{.git,node_modules}"'
export LS_COLORS=exfxcxdxbxegedabagacad # set default LS_COLORS for use by fd
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/anand/.claude/local:$PATH"
export GOPATH="/Users/anand/.go"
export BAT_THEME="catppuccin_mocha"

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

export PS1='%F{green}%n%F{reset_color}@%F{red}%m%F{reset_color}:%F{blue}%~ %F{magenta}${vcs_info_msg_0_}${NEWLINE}%F{reset_color}$ '

setopt inc_append_history
setopt share_history
setopt interactivecomments

alias vi="/opt/homebrew/bin/nvim"
alias py="/opt/homebrew/bin/python3"
alias rg="rg --colors 'path:fg:blue' --colors 'match:fg:yellow'"
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

export MANPAGER='nvim +Man!'
