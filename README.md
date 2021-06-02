# dotfiles

各个 App 一般会有个性化配置，dotfiles 就是保存这些自定义配置，换了一个设备，只需还原即可。

在系统中使用一个文件夹，通过 ls 还是 ln -s (symbolic)命令，将不同的app，不同的系统设置文件都指引到这个文件夹，这样就可以在这个文件夹管理所有的系统app setting了。

文件夹可以通过 git 、 dropbox 进行备份。



## 初始化安装配置

-  👉 macOS

-  👉 安装 Xcode Command Line Tools
-  👉 开启 Terminal   🤙命令成功执行后  推荐用 iTerm 2

```sh
# Xcode Command Line Tools
xcode-select --install

git clone git@github.com:ynthm/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sh bootstrap.sh
```

`bootstrap.sh` 自动完成工作:

1. 检查并安装 [Homebrew](http://brew.sh/)。
2. 检查并安装 [Oh My Zsh](http://ohmyz.sh/)。
3. 更新并安装 Homebrew packages (binaries, fonts, apps)。
4. 检查并建立软连接 dotfiles (.zshrc, .vimrc, .gitconfig, .gitignore, ...)。



## Github 备份 dotfiles

创建自己的  dotfiles 文件夹，备份自己的配置。

```sh
cd
mkdir -p ~/.dotfiles/config/zsh
cp ~/.zshrc ~/.dotfiles/config/zsh/zshrc.symlink
brew bundle dump --describe --force --file="~/.dotfiles/homebrew/Brewfile"
```



提交到 Github， 现在 Github 创建空的 dotfiles

```sh
cd .dotfiles
git init
git remote add origin git@github.com:ynthm/dotfiles.git
# 非私人终端提交请设置
git config user.name "Ynthm Wang"
git config user.email "ynthm.w@gmail.com"

git add .
git commit -m 'init dotfiles'
git push -u origin master
```
