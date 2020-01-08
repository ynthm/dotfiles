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



打开 `Beyond Compare`  > `Beyond Compare Menu`  > `Install Command Line Tools`
 必须要安装Beyond Compare 命令工具，否则会报错。

```properties
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



## sourcetree

Virtual Studio Code 作为  diff 工具

偏好设置  Diff

可视化对比工具  自定义

命令 /usr/local/bin/code

参数  `--wait --diff $LOCAL $REMOTE`

合并工具 自定义

命令 /usr/local/bin/code

参数  ` --wait $MERGED`

