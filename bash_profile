export PATH="/usr/local/git/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH"

export PATH="${PATH}:/Library/Python/2.7/site-packages/django/bin"

export PATH="${PATH}:/usr/texbin"

export PATH="${PATH}:$HOME/Dropbox/Scripts/bin"

export PATH="${PATH}:$HOME/bin"

export PATH="${PATH}:$HOME/bin/apache-maven-3.5.0/bin"

export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_12_HOME=$(/usr/libexec/java_home -v12)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java12='export JAVA_HOME=$JAVA_12_HOME'

# default to Java 12
java12

export CATALINA_HOME="/Users/Aksel/opt/tomcat/apache-tomcat-7.0.55"

export PATH=~/opt/mvn/bin:$PATH

export KUBECONFIG="/Users/akselwester/Projects/kubeconfigs/config"
alias k='kubectl'
alias kluster='kubectl config use-context'

kompare() {
    if [ -z "$1" ] || [ -z "$2" ]
    then
        echo "Usage: kompare sone app"
    else
	current=$(k config current-context)

	kluster preprod-$1 &> /dev/null
	IN=$(k get deployment $2 -n q0 -o json | jq .spec.template.spec.containers[0].image -r)
	arrIN=(${IN//:/ })
	preprod_version=${arrIN[2]}

	echo -e "$2, preprod-$1: $preprod_version"

	kluster prod-$1 &> /dev/null
	IN=$(k get deployment $2 -o json | jq .spec.template.spec.containers[0].image -r)
	arrIN=(${IN//:/ })
	prod_version=${arrIN[2]}
	echo -e "$2, prod-$1:    $prod_version"

	kluster $current &> /dev/null
    fi
}

alias ll='ls -l'

alias emacs='open /Applications/Emacs.app'

alias python=python3.5

alias pydoc=pydoc3

alias pip=pip3.5

alias virtualenv='python -m virtualenv'

alias django='source ~/virtualenvs/django/bin/activate'

alias pyenv='source ~/virtualenvs/pyenv/bin/activate'

alias scikit='source ~/env/scikit/bin/activate'

alias mci='mvn clean install'

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


alias gits='git status'
alias gitco='git checkout'
alias gitb='git branch'
__git_complete gitco _git_checkout
__git_complete gitb _git_branch

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_branch_with_parens() {
    if [ ! -z "$(parse_git_branch)" ]; then
	echo "($(parse_git_branch))";
    else
	echo ""
    fi;
}

git_push_new() {
    git push -u origin `parse_git_branch`
}

alias gitpn='git_push_new'

open_pull_request() {
    GITHUB_URL=$(git config --get remote.origin.url)
    open "${GITHUB_URL%.git}/pull/$(parse_git_branch)"
}

alias git_open_pr='open_pull_request'
alias gitpr='git_open_pr'

alias git_stash_unstaged='git stash --keep-index --include-untracked'

alias gitsu='git_stash_unstaged'

alias git_delete_merged='git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'

export PS1="\n\$(dirs)\033[32m\] \$(git_branch_with_parens)\[\033[00m\]\n$ "

test -r @PREFIX@/bin/init.sh && . @PREFIX@/bin/init.sh

test -r @PREFIX@/bin/init.sh && . @PREFIX@/bin/init.sh

test -r @PREFIX@/bin/init.sh && . @PREFIX@/bin/init.sh

test -r @PREFIX@/bin/init.sh && . @PREFIX@/bin/init.sh

# Setting PATH for Python 3.3
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"
export PATH

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH
export PATH=/usr/local/bin:$PATH

# Gjorde dette for branch filter git
#export JAVA_HOME=/Library/Java/Home

##
# Your previous /Users/Aksel/.bash_profile file was backed up as /Users/Aksel/.bash_profile.macports-saved_2015-09-23_at_14:36:36
##

# MacPorts Installer addition on 2015-09-23_at_14:36:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:$PATH"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH


PATH="${PATH}:/Users/Aksel/opt/srilm-1.7.1/bin/:/Users/Aksel/opt/srilm-1.7.1/bin/macosx/"
export PATH


# Open SSL
export PATH=/usr/local/openssl/bin:$PATH
export MANPATH=/usr/local/openssl/ssl/man:$MANPATH

alias docker_kill_all='docker kill $(docker ps -q)'
alias dockerka=docker_kill_all
alias dcu='docker-compose up'

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
        echo "Usage: linesofcode folder extension (for instance 'linesofcode src/ .elm'"
    else
	find $1 -name "*$2" | xargs wc -l
    fi
}

alias linesofcode="lines_of_code"
alias loc="lines_of_code"

alias start="npm start"
alias startveileder="npm run start-veileder"

export PATH=/Users/akselwester/bin/sc-4.5.3-osx/bin:$PATH
alias sctunnel="sc -u $SAUCE_USERNAME -k $SAUCE_ACCESS_KEY -x https://eu-central-1.saucelabs.com/rest/v1 -i awester-pc"


alias restart='echo "Restarter bash fra source ~/.bash_profile" && source ~/.bash_profile'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/akselwester/.sdkman"
[[ -s "/Users/akselwester/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/akselwester/.sdkman/bin/sdkman-init.sh"


# TEMP - Skjema demo

alias start0="gitco tags/steg-0 && npm run start-skjema-demo"
alias start1="gitco tags/steg-1 && npm run start-skjema-demo"
alias start2="gitco tags/steg-2 && npm run start-skjema-demo"
alias start3="gitco tags/steg-3 && npm run start-skjema-demo"
alias start4="gitco tags/steg-4 && npm run start-skjema-demo"
alias start5="gitco tags/steg-5 && npm run start-skjema-demo"
alias start6="gitco tags/steg-6 && npm run start-skjema-demo"
alias start7="gitco tags/steg-7 && npm run start-skjema-demo"
alias start8="gitco tags/steg-8 && npm run start-skjema-demo"
