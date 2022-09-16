export HOMEBREW_NO_AUTO_UPDATE=true
# go
export GOPATH=$HOME/Applications/go
export PATH=$PATH:$GOPATH/bin

# homebrew install library
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@9.6/bin:$PATH"

# hadoop
export PATH=$PATH:/Users/ynthm/Apps/Hadoop/hadoop-3.3.2/bin:/Users/ynthm/Apps/Hadoop/hadoop-3.3.2/sbinexport PATH="/opt/homebrew/sbin:$PATH"

# Python
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Node.js
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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
# tput_colors - Demonstrate color combinations.
function colors(){
    for fg_color in {0..7}; do
        set_foreground=$(tput setaf $fg_color)
        for bg_color in {0..7}; do
            set_background=$(tput setab $bg_color)
            echo -n $set_background$set_foreground
            printf ' F:%s B:%s ' $fg_color $bg_color
        done
        echo $(tput sgr0)
    done
}

# ANSI escape codes
function colors-ANSI(){
    echo -E "\033[字背景颜色;字体颜色m字符串\033[0m"
    # for code ({000..255}) print -P -- "$code : %F{$code}Winter is coming"
    echo "字颜色"
    for code ({30..37}) echo -e "$code \033[0;$code;5m FBI WARNING \033[0m"
    echo "背景颜色"
    for code ({40..47}) echo -e "$code \033[$code;5m FBI WARNING \033[0m"
    echo "字加亮颜色"
    for code ({90..97}) echo -e "$code \033[$code;5m FBI WARNING \033[0m"
    echo "背景加亮颜色"
    for code ({100..107}) echo -e "$code \033[$code;5m FBI WARNING \033[0m"
}

function info()
{
    echo -e "\033[32m INFO: $1 \033[0m"
}

function error()
{
    echo -e "\033[31m ERROR: $1 \033[0m"
}