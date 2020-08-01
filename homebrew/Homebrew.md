## Homebrew

安装 App 一般有以下方式

- App Store 软件商店
- brew  包该管理工具



[Homebrew](https://brew.sh/) macOS 包管理工具，官方称之为缺失的软件包的管理器

与 Homebrew 搭配最常用的是 Homebrew-Cask ，它有点类似于一个开源的 App Store。

Homebrew只能用于安装命令行软件，不能用于安装带图形界面的软件。Homebrew-Cask是Homebrew的 一个扩展，可以用于安装带图形界面软件

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```sh
# 搜索软件包，支持模糊搜索。  
brew search <package-name>

# 安装软件
brew install <Formulae>
brew cask install <Casks>

# 列出通过 Homebrew Cask 安装的包
brew list
brew cask list
# 查看相关软件的信息
brew info <package-name>
brew cask info <package-name>
# 更新 Homebrew Cask
brew update
# brew update --verbose
# brew upgrade 软件比较多网络问题建议单个更新 brew cask upgrade
brew upgrade youtube-dl
brew cask upgrade typora

# 卸载 uninstall
brew uninstall <package-name>
brew cask uninstall <package-name>

# 查看帮助
brew --help
brew cask --help
```



```sh
brew tap homebrew/cask-fonts
brew untap homebrew/cask-fonts
```



```sh
# curl 无法下载 代理 待测试
vim ~/.curlrc
```

```properties
socks5 = "127.0.0.1:1086"
```





## [brew bundle](https://github.com/Homebrew/homebrew-bundle) 备份软件

[Homebrew](https://github.com/Homebrew/brew) (on macOS or [Linux](https://docs.brew.sh/Homebrew-on-Linux)) for installing the dependencies.

[Homebrew Cask](https://github.com/Homebrew/homebrew-cask) is optional and used for installing Mac applications.

[mas-cli](https://github.com/argon/mas) is optional and used for installing Mac App Store applications.



```sh
# 安装 mas 如果你想备份 App Store 的软件
brew install mas
brew bundle dump --describe --force --file="~/Desktop/Brewfile"
```

--describe：为列表中的命令行工具加上说明性文字。

--force：直接覆盖之前生成的Brewfile文件。如果没有该参数，则询问你是否覆盖。

--file="~/Desktop/Brewfile"：在指定位置生成文件。如果没有该参数，则在当前目录生成 Brewfile 文件。

```sh
brew bundle check
brew bundle list --all
# 批量安装软件
brew bundle --file="~/Desktop/Brewfile"
```





## 源

```sh
# 以下针对 mac OS 系统上的 Homebrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git
```



```shell
cd "$(brew --repo)" 
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git 

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" 
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git 

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
# 不自动更新
echo 'export HOMEBREW_NO_AUTO_UPDATE=true' >> ~/.zshrc
```







## 无法下载安装文件

```sh
# 查看安装文件缓存位置
brew --cache
ll ~/Library/Caches/Homebrew
ll ~/Library/Caches/Homebrew/Cask

cd ~/Library/Caches/Homebrew/Cask
wget https://osx.telegram.org/updates/Telegram-5.9.1.189475.app.zip
brew cask install telegram

aria2c --all-proxy="http://127.0.0.1:1087" https://github.com/JohnCoates/Aerial/releases/download/v1.9.2/Aerial.saver.zip
brew cask info aerial
# aerial: 1.9.2
mv Aerial.saver.zip aerial--1.9.2.zip

aria2c --all-proxy="http://127.0.0.1:1087" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
```



搭建 http 服务器

```sh
brew cask edit aerial
# 手动下载 url 对应的安装包，放置 http 服务器下。
# 将 url 修改为 http 服务器对应文件的网址

# 修改的 git 仓库在下面目录，可以回退
cd $(brew --repo homebrew/cask)
cd $(brew --repo homebrew/core)
```

