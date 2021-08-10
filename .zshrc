# Shell Options
setopt AUTO_CD                 # Auto insert cd in from of directory
setopt EXTENDED_HISTORY        # More info with history like elasped time
setopt SHARE_HISTORY           # Share history across multiple zsh sessions
setopt APPEND_HISTORY          # Append to history
setopt INC_APPEND_HISTORY      # Append after command is run
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicates first
setopt HIST_REDUCE_BLANKS      # Remove blank lines from history
setopt HIST_FIND_NO_DUPS       # Ignore duplicates when searching
setopt AUTO_MENU

# Keybindings
bindkey "^[[1;2D" backward-word
bindkey "^[[1;2C" forward-word
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-z/zsh-z.plugin.zsh

# Autocompletion Setup
fpath+=~/.zsh/.zfunc  # Custom Autocompletions
fpath=(~/.zsh/zsh-completions/src $fpath)

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select # select completions with arrow keys
# zstyle ':completion:*' verbose true
zstyle ':completion:*' group-name ''

# iTerm Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# Aliases
alias ls='ls -G'
alias ll='ls -Alh'


# Python Setup
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
  eval "$(pyenv virtualenv-init - zsh)"
fi


# Google Cloud Setup
if [ -f '/Users/slade/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/slade/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/slade/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/slade/google-cloud-sdk/completion.zsh.inc'; fi

function colored() {
	command env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		PAGER="${commands[less]:-$PAGER}" \
		_NROFF_U=1 \
		PATH="$HOME/bin:$PATH" \
			"$@"
}

# Colorize man and dman/debman (from debian-goodies)
function man \
	dman \
	debman {
	colored $0 "$@"
}

# SML Setup
alias smlnj='rlwrap /usr/local/smlnj/bin/sml'
alias sml='/usr/local/smlnj/bin/sml'

export UNAME=Darwin


# NVM Setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Flutter Setup
export PATH="$PATH:$HOME/flutter/bin"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"

