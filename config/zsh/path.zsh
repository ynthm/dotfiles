export HOMEBREW_NO_AUTO_UPDATE=true
# go
export GOPATH=$HOME/Applications/go
export PATH=$PATH:$GOPATH/bin

# homebrew install library
export PATH="/opt/homebrew/bin:$PATH"

# Python
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Node.js
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


# Load Zsh tools for syntax highlighting and autosuggestions
HOMEBREW_FOLDER="/opt/homebrew/share"
source "$HOMEBREW_FOLDER/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOMEBREW_FOLDER/zsh-autosuggestions/zsh-autosuggestions.zsh"
# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# Configuring Completions in zsh zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# Java
function setjdk() {
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
    export CLASS_PATH=$JAVA_HOME/lib
}

function jdk8(){
    setjdk 1.8
}
function jdk11(){
    setjdk 11
}
function java-v(){
    /usr/libexec/java_home -V
}
