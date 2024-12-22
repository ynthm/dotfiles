# export DOCKER_HOST=tcp://10.0.0.30:2375
# export http_proxy=http://10.0.0.30:7897
# export https_proxy=http://10.0.0.30:7897
# export no_proxy=localhost,127.0.0.1

export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/Apps/bin
export PATH=$PATH:~/Apps/bin/rspleeter
export HOMEBREW_NO_AUTO_UPDATE=true
# homebrew install library
export PATH="/opt/homebrew/bin:$PATH"
# go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# postgresql
# export PATH="/opt/homebrew/opt/postgresql@9.6/bin:$PATH"

export PATH=$PATH:/Users/ynthm/Apps/gradle/gradle-8.1.1/bin

# hadoop
export PATH=$PATH:/Users/ynthm/Apps/Hadoop/hadoop-3.3.2/bin:/Users/ynthm/Apps/Hadoop/hadoop-3.3.2/sbinexport PATH="/opt/homebrew/sbin:$PATH"

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
