alias md="mkdir -p"

alias bs='brew search'
alias bi='brew install'
alias bif='brew info'
alias bcin='brew install --cask'
alias br='brew uninstall'
alias bl='brew list'
alias blf='brew list --formula --versions'
alias blc='brew list --cask --versions'

pcp='rsync -r --progress'

# alias yF='youtube-dl -F --no-check-certificate'
# $YDL -U 升级  $YDL --version
# ~/.config/youtube-dl/config
YDL=~/Apps/yt-dlp/yt-dlp_macos
alias yF="$YDL -F --no-check-certificate"
alias yf="$YDL -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]' --no-check-certificate"
alias yfb="$YDL -f 'bestvideo+bestaudio' --no-check-certificate"

alias ysub="$YDL --all-subs --skip-download"

alias port-listen="lsof -i -P | grep -i "LISTEN""

alias ll='eza -l --icons'
