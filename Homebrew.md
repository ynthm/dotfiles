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
brew cask upgrade

# 卸载 uninstall
brew uninstall <package-name>
brew cask uninstall <package-name>

# 查看帮助
man brew
man brew-cask
```







## brew bundle 备份软件

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