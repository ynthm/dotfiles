alias brew='/opt/homebrew/bin/brew' # ARM Homebrew
alias ibrew='arch -x86_64 /usr/local/bin/brew' # X86 Homebrew
alias md="mkdir -p"

alias bs='brew search'
alias bi='brew install -s'
alias bif='brew info'
alias br='brew uninstall'
alias bcr='brew cask zap'

alias yF='youtube-dl -F --no-check-certificate'
alias yf="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]' --no-check-certificate"
alias yfb="youtube-dl -f 'bestvideo+bestaudio' --no-check-certificate"

alias ysub="youtube-dl --all-subs --skip-download"

# alias ytbestmp4="yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b""

alias port-listen="lsof -i -P | grep -i "listen""