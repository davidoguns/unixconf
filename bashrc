# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#vi mode
set -o vi

# User specific aliases and functions
alias brenv='env CONFIG_DIR=/opt/bedrock/config $@'
alias twlenv='env TWL_CORE_CONFIGURATION_PROP=/opt/twl_resources/configuration/core-configuration.properties $@'
alias btenv='env CONFIG_DIR=/opt/bedrock/config TWL_CORE_CONFIGURATION_PROP=/opt/twl_resources/configuration/core-configuration.properties $@'
alias setmvncp="CLASSPATH=\$(mvn dependency:build-classpath | grep -v '^\[.*')"

function setsbtcp() {
  CLASSPATH=`sbt "show full-classpath" | grep List | cut -b24- | sed 's/List(Attributed(//g' | sed 's/),\sAttributed(/:/g' | sed 's/))//g'`
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local      YELLOW="\[\033[1;33m\]"
  local       BLACK="\[\033[0;30m\]"
  local       BROWN="\[\033[0;33m\]"
  local	      RESET="\[\033[0;0m\]"

   PS1="$BLUE[$BROWN\u@\h:\W$GREEN\$(parse_git_branch)$BLUE]$RESET\$ "
}
proml

alias gcode='gvim --servername code --remote-tab'
alias gprop='gvim --servername prop --remote-tab'
alias gopen='gvim --servername open --remote-tab'
alias glist='gvim --serverlist'

gitdir() {
  cwd=`pwd` #store current working directory
  for dir in `find $cwd -maxdepth 1 -type d`
  do
    echo "Running '$@' in directory: $dir..."
    cd $dir #switch into directory
    $@
  done

  cd $cwd #go back to original directory
}

setjcp() {
  DIR=.
  if [ $# -gt 1 ]
  then
    DIR=$1
  fi
  CLASSPATH=`find $DIR -name "*.jar" | tr '\012' ':'`
}

appjcp() {
  DIR=.
  if [ $# -gt 1 ]
  then
    DIR=$1
  fi
  CLASSPATH=$CLASSPATH:$(find $DIR -name "*.jar" | tr '\012' ':')
}

alias showjcp='echo $CLASSPATH'

#needed for rails application to find database passwords and decrypte
export BCDATABASE_PATH=~/nubic/db
export BCDATABASE_PASS=~/nubic/db/pass/db.pass

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function


#common monitor arrangement
alias fix_monitors='xrandr --output VBOX0 --auto --above VBOX1'
