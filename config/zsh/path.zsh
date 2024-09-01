export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/Apps/bin
export PATH=$PATH:~/Apps/bin/rspleeter
export HOMEBREW_NO_AUTO_UPDATE=true
# homebrew install library
export PATH="/opt/homebrew/bin:$PATH"
# go
export GOPATH=/usr/local/go
export PATH=$PATH:$GOPATH/bin
# postgresql
# export PATH="/opt/homebrew/opt/postgresql@9.6/bin:$PATH"

export PATH=$PATH:/Users/ynthm/Apps/gradle/gradle-8.1.1/bin

# hadoop
export PATH=$PATH:/Users/ynthm/Apps/Hadoop/hadoop-3.3.2/bin:/Users/ynthm/Apps/Hadoop/hadoop-3.3.2/sbinexport PATH="/opt/homebrew/sbin:$PATH"

# Node.js
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
