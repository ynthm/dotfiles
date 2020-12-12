## git

git 全局配置

```sh
vim ~/.gitconfig
```

```properties
[user]
	name = Ynthm Wang
	email = ynthm.w@gmail.com
[http]
	postBuffer = 524288000
[alias]
	a = add
	b = branch
	c = commit
	co = checkout
	st = status
	dt = difftool
    dtst = difftool --tool=sourcetree    
    mt = mergetool
    mtst = mergetool --tool=sourcetree
    lgst = log --name-status
	lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
[core]
	excludesfile = ~/.gitignore_global

[difftool "vscode"]
	cmd = /usr/local/bin/code --wait --diff $LOCAL $REMOTE
[mergetool "vscode"]
	cmd = /usr/local/bin/code --wait $MERGED
	trustExitCode = true
[difftool "sourcetree"]
	cmd = /usr/local/bin/stree --wait --diff $LOCAL $REMOTE
[mergetool "sourcetree"]
	cmd = /usr/local/bin/stree --wait $MERGED
	trustExitCode = true
	
# git config --global diff.tool vscode
[diff]
  tool = vscode
# git config --global merge.tool vscode
[merge]
  tool = vscode
```

```sh
git difftool --tool=vscode
git config --global diff.tool vscode
git config --global merge.tool vscode

# git dt
git difftool
# 命令用于运行合并冲突解决工具来解决合并冲突。它通常在git合并后运行。
git mergetool
```



打开 `Beyond Compare`  > `Install Command Line Tools`
 必须要安装Beyond Compare 命令工具，否则会报错。

```properties
[alias]
    dtbc = difftool --tool=bc
    dtbc = difftool --tool=bc
[difftool "bc"]
	cmd = /usr/local/bin/bcomp $LOCAL $REMOTE
[mergetool "bc"]
	cmd = /usr/local/bin/bcomp $LOCAL $REMOTE $BASE $MERGED
	trustExitCode = true
```



```sh
cd ~/.dotfiles
# 在非私人电脑提交代码，需设置本地属性
git config user.name "Ynthm Wang"
git config user.email "ynthm.w@gmail.com"
git config --local --list
```



sourcetree

Virtual Studio Code 作为  diff 工具

偏好设置  Diff

可视化对比工具  自定义

命令 /usr/local/bin/code

参数  `--wait --diff $LOCAL $REMOTE`

合并工具 自定义

命令 /usr/local/bin/code

参数  ` --wait $MERGED`





## Java

macOS 已经提供`/usr/libexec/java_home`工具来管理安装的 JDK。

Homebrew 不支持 Oracle JDK 1.8 了，推荐尽量使用 OpenJDK，如果现有项目不兼容可 Oracle 官网下载手动安装。

```sh
brew tap AdoptOpenJDK/openjdk
brew cask install <version>
```



jenv 不推荐

- 需要手动把`eval "$(jenv init -)"`加入 profile
- 需要手动添加 JDK，不会自动采集系统 JDK。
- 需要 `jenv rehash`



```sh
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
```





## MongoDB

```sh
brew tap mongodb/brew
brew search mongodb
brew install mongodb-community@4.2

mongod --config /usr/local/etc/mongod.conf --fork
# brew services start mongodb-community

ps aux | grep mongod

tail -fn 100 /usr/local/var/log/mongodb/mongo.log
mongod --version

# ⌘+T 新窗口  Connect and Use MongoDB 
mongo
mongo --port 28015
mongo --host mongodb0.example.com:28015
```





## Python

[pyenv](https://github.com/yyuu/pyenv)   同一个环境安装多个不同的Python版本

[pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv)  **pyenv 插件**是虚拟出某一版本的python但是不同依赖库版本的Python环境

```sh
brew update
brew install pyenv

# bash 的方式 ~/.zshrc 修改为 ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
exec $SHELL

# 安装依赖
brew install zlib
# 手打，可能版本不一致
ln -s /usr/local/Cellar/zlib/1.2.11/include/* /usr/local/include
ln -s /usr/local/Cellar/zlib/1.2.11/lib/* /usr/local/lib

# pyenv install --list
pyenv install 3.6.6
# 安装后最好 rehash
pyenv rehash

# pyenv virtualenv插件 虚拟环境管理
brew install pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
exec $SHELL

# 查看当前激活的是那个版本的Python
pyenv version
# 查看已经安装了那些版本的Python
pyenv versions
# 创建虚拟环境
pyenv virtualenv 3.6.6 env366
# 激活虚拟环境
pyenv activate env366
# 释放
pyenv deactivate
# 删除虚拟环境
pyenv uninstall env366
```

[pyenv commands](