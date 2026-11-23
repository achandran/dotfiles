bindkey -v
bindkey 'jk' vi-cmd-mode
# Match Ghostty selection: Everforest Dark Medium (bg_visual); only bg is set so text keeps its color
zle_highlight=(region:bg=#543A48,paste:bg=#543A48)

export CLICOLOR=1
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore --follow --exclude "{.git/*,node_modules/*}"'
export FZF_CTRL_T_COMMAND='fd --type d --no-ignore --follow --exclude "{.git,node_modules}"'
# Use the terminal's ANSI palette; current line uses Everforest bg_green with green accent highlights
export FZF_DEFAULT_OPTS='--color=base16,bg+:#425047,fg+:-1:regular,hl:#A7C080,hl+:#A7C080:bold,pointer:#A7C080,prompt:#A7C080,marker:#E69875,border:#56635F,gutter:-1'
# GNU equivalent of macOS's default LSCOLORS (exfxcxdxbxegedabagacad), for fd
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export BAT_THEME=ansi
export PATH="/opt/homebrew/bin:$PATH"

# Add extra, user-specified completions
fpath+=~/.zfunc

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
source "$HOME/code/haskell/tt/shell/tt-completion.zsh"
zstyle ':completion:*' menu select

# Prompt (vcs_info, PS1) lives in its own file so the Claude Code status line can share it
source ~/.config/zsh/prompt.zsh

# History configuration for sharing across Ghostty tabs
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
alias ai="agy"

fpath=(~/.zsh $fpath)
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export MANPAGER='nvim +Man!'


# Added by Antigravity CLI installer
export PATH="/Users/anand/.local/bin:$PATH"
