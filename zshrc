
### PROMPT

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f'
zstyle ':vcs_info:*' enable git

PROMPT=$'\n'"%~ \$vcs_info_msg_0_"$'\n'"$ "



### ZSH SETTINGS

setopt AUTO_CD
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
# share history across multiple zsh sessions
setopt NO_SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
# verify last command using !! before executing
setopt HIST_VERIFY
# Don't suggest corrections for mistyped commands
unsetopt CORRECT
unsetopt CORRECT_ALL



### COMPLETION SYSTEM

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

[[ -r ~/Projects/autopkg_complete/autopkg ]] && source ~/Projects/autopkg_complete/autopkg

# initialize the zsh completion system
autoload -Uz compinit && compinit



### ALIAS

alias restart='echo "Restarter zsh fra source ~/.zshrc" && source ~/.zshrc'

alias ll='ls -l'
alias emacs='open /Applications/Emacs.app'

alias gits='git status'
alias gitco='git checkout'
alias gitb='git branch'
alias git_stash_unstaged='git stash --keep-index --include-untracked'
alias gitsu='git_stash_unstaged'
alias git_delete_merged='git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'

main_branch() {
    echo `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`
}

alias gitm='git checkout $(main_branch)'


open_pull_request() {
    GITHUB_URL=$(git config --get remote.origin.url)
    open "${GITHUB_URL%.git}/pull/$(parse_git_branch)"
}

alias git_open_pr='open_pull_request'
alias gitpr='git_open_pr'


alias mci='mvn clean install'
alias n='npm'
alias start='npm start'
alias s='npm start'
alias nuse='nvm use'
alias Projects='~/Projects'
alias P='Projects'

kill_port() {
    if [ -z "$1" ]
    then
        echo "Usage: killport port_number"
    else
	PID=$(lsof -t -i :$1)

	if [ -z "$PID" ]
	then
	    echo "No process using port $1"
	else
	    echo "Killing process using port $1"
	    kill $PID
	fi
    fi
}

alias killport="kill_port"

lines_of_code() {
    if [ -z "$1" ]
    then
        echo "Usage: linesofcode folder extension (for instance 'linesofcode src/ .elm')"
    else
	find $1 -name "*$2" | xargs wc -l
    fi
}

alias linesofcode="lines_of_code"
alias loc="lines_of_code"

root() {
    if [ ! -d "./.git" ] && [ $(pwd) != "/" ] && cd .. && root
}

path+=('/Users/aksel/.local/bin')
path+=('$HOME/.cargo/env')
export PATH

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
