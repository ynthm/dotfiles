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

[pyenv commands](https://github.com/pyenv/pyenv/blob/master/COMMANDS.md)