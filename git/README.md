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
	cob = checkout
	st = status
	lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
[core]
	excludesfile = ~/.gitignore_global
[difftool "sourcetree"]
	cmd = /usr/local/bin/code --wait --diff $LOCAL $REMOTE
	path = 
[mergetool "sourcetree"]
	cmd = /usr/local/bin/code --wait $MERGED
	trustExitCode = true
```

```sh
git difftool
# 命令用于运行合并冲突解决工具来解决合并冲突。它通常在git合并后运行。
git mergetool
```



```sh
cd ~/.dotfiles
# 在非私人电脑提交代码，需设置本地属性
git config user.name "Ynthm Wang"
git config user.email "ynthm.w@gmail.com"
git config --local --list
```



## sourcetree

Virtual Studio Code 作为  diff 工具

偏好设置  Diff

可视化对比工具  自定义

命令 /usr/local/bin/code

参数  `--wait --diff $LOCAL $REMOTE`

合并工具 自定义

命令 /usr/local/bin/code

参数  ` --wait $MERGED`

