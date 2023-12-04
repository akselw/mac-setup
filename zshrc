
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
alias tf="terraform"

alias gits='git status'
alias gitco='git switch'
alias gitb='git branch'
alias git_stash_unstaged='git stash --keep-index --include-untracked'
alias gitsu='git_stash_unstaged'
alias git_delete_merged='git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'
alias gitpn='git push -u origin HEAD'
alias gam='git commit --amend'
alias gamno='git commit --amend --no-edit'

main_branch() {
    git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4
}

git_rm_merged() {
    git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]"{ print $1 }' | xargs -r git branch -D
}

git_sync() {
    git switch $(main_branch) && git pull --prune && git_rm_merged
}

alias gitm='git checkout $(main_branch)'

alias current_git_branch='git rev-parse --abbrev-ref HEAD'

open_pull_request() {
    GITHUB_URL=$(git config --get remote.origin.url)
    open "${GITHUB_URL%.git}/pull/new/$(current_git_branch)"
}

alias git_open_pr='open_pull_request'
alias gitpr='git_open_pr'

alias gith='open $(git remote get-url origin)'

alias mci='mvn clean install'
alias n='npm'
alias start='npm start'
alias s='npm start'
alias nuse='nvm use'

cd_to_Projects() {
    cd ~/Projects/$1
}

_cd_to_Projects_completion2() {
    _alternative "dirs:user directory:($(ls ~/Projects))"
}

alias P='cd_to_Projects'

compdef _cd_to_Projects_completion2 cd_to_Projects
compdef P=cd_to_Projects

nlang() {
    npm run language:$1
}

alias lurl='npm run launch-urls'

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
alias week="date +%V"
alias isodate='date +'\''%Y-%m-%dT%H:%M:%SZ'\'

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
path+=('/Applications/IntelliJ IDEA.app/Contents/MacOS')
path+=('$HOME/.cargo/env')
export PATH

# eval "$(jenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


_deploy-to-env-vy() {
    version=""
    if [ -z "$2" ]
    then
        vared -p 'Version number: ' -c version
    else
        version=$2
    fi
    AWS_DEFAULT_REGION=eu-central-1 AWS_PROFILE=omni-admin ./deploy.sh $1 $version
}

test2-deploy() {
    _deploy-to-env-vy test2 $1
}

test4-deploy() {
    _deploy-to-env-vy test4 $1
}

prod-deploy() {
    _deploy-to-env-vy prod $1
}

# direnv setup
eval "$(direnv hook zsh)"

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
