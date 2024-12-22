alias brew='/opt/homebrew/bin/brew' # ARM Homebrew
alias ibrew='arch -x86_64 /usr/local/bin/brew' # X86 Homebrew
alias md="mkdir -p"

alias bs='brew search'
alias bi='brew install -s'
alias bif='brew info'
alias br='brew uninstall'
alias bcr='brew cask zap'

pcp='rsync -r --progress'

# alias yF='youtube-dl -F --no-check-certificate'
# $YDL -U 升级  $YDL --version
# ~/.config/youtube-dl/config
YDL=~/Apps/yt-dlp/yt-dlp_macos
alias yF="$YDL -F --no-check-certificate"
alias yf="$YDL -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]' --no-check-certificate"
alias yfb="$YDL -f 'bestvideo+bestaudio' --no-check-certificate"

alias ysub="$YDL --all-subs --skip-download"

alias port-listen="lsof -i -P | grep -i "listen""
