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

