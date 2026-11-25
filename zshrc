
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
HISTSIZE=10000
# don't share history across multiple zsh sessions
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
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# initialize the zsh completion system
autoload -Uz compinit && compinit

# load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

[[ -r ~/Projects/autopkg_complete/autopkg ]] && source ~/Projects/autopkg_complete/autopkg



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

alias gitm='git switch $(main_branch)'

alias current_git_branch='git rev-parse --abbrev-ref HEAD'

open_pull_request() {
    GITHUB_URL=$(git config --get remote.origin.url)
    open "${GITHUB_URL%.git}/pull/new/$(current_git_branch)"
}

alias git_open_pr='open_pull_request'
alias gitpr='git_open_pr'

alias gith='open $(git remote get-url origin)'

git_md() {
  if [[ -z $1 ]]; then
    print -u2 "usage: git_md <number-of-commits|revision>"
    return 1
  fi

  local -a range
  if [[ $1 == <-> ]]; then
    range=(-n "$1")
  elif [[ $1 == *..* ]]; then
    range=("$1")
  elif git rev-parse --verify --quiet "$1^{commit}" >/dev/null; then
    range=("$1..HEAD")
  else
    print -u2 "git_md: '$1' is not a number or a known revision"
    return 1
  fi

  git log "${range[@]}" --reverse --format='%w(0,0,2)- %B' | sed '/^$/d'
}

_git_md() {
  (( CURRENT > 2 )) && return 1
  local -a branches
  branches=(${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null)"})
  _describe -t branches 'branch' branches
}
compdef _git_md git_md

alias mci='mvn clean install'
alias n='npm'
alias nr='npm run'
alias p='pnpm'
alias pr='pnpm run'
alias start='pnpm start'
alias s='pnpm start'
alias d='pnpm dev'
alias v='pnpm fast-validate'
alias nuse='nvm use'
alias c='claude'

cd_to_Projects() {
    cd ~/Projects/$1
}

_cd_to_Projects_completion2() {
    _alternative "dirs:user directory:($(ls ~/Projects))"
}

alias P='cd_to_Projects'

compdef _cd_to_Projects_completion2 cd_to_Projects
compdef P=cd_to_Projects


cd_to_Monorepo() {
    cd ~/Projects/kss-monorepo/$1
}

_cd_to_Monorepo_completion2() {
    _alternative "dirs:user directory:($(ls ~/Projects/kss-monorepo/))"
}

alias M='cd_to_Monorepo'

compdef _cd_to_Monorepo_completion2 cd_to_Monorepo
compdef M=cd_to_Monorepo

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
	    echo $PID | xargs kill
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

path+=("$HOME/.local/bin")
path+=('/Applications/IntelliJ IDEA.app/Contents/MacOS')
path+=("$HOME/.cargo/bin")
path+=('/opt/homebrew/bin')
export PATH

[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# eval "$(jenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export NPM_CONFIG_IGNORE_SCRIPTS=true

awslogin() {
    PROFILE_NAME="${1:-dev}"

    if [[ -z "$1" ]]; then
        echo "No profile specified. Using default profile 'dev'."
    fi

    aws sso login --profile "$PROFILE_NAME"
}

reset_docker () {
    colima stop
    colima start
    docker network prune -f
    docker container prune -f
}

###-begin-pnpm-completion-###
if type compdef &>/dev/null; then
  _pnpm_completion () {
    local reply
    local si=$IFS
    local _pnpm_line="${(j: :)words[1,CURRENT]}"

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$_pnpm_line" COMP_POINT="${#_pnpm_line}" SHELL=zsh pnpm completion-server -- "${words[@]}"))
    IFS=$si

    if [ "$reply" = "__tabtab_complete_files__" ]; then
      _files
    else
      _describe 'values' reply
    fi
  }

  if [[ $zsh_eval_context == *func ]]; then
    _pnpm_completion "$@"
  else
    compdef _pnpm_completion pnpm
  fi
fi

###-end-pnpm-completion-###

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
