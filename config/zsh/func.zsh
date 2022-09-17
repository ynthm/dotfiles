function info {
  printf "\r\033[32m🍀 $1\033[0m\n"
}
function warning {
  printf "\r\033[93m🔞 $1\033[0m\n"
}
# 用户选择
function choose {
  printf "\r\033[95m🌸 $1\033[0m\n"
}

function error {
  echo -e "\033[91m🍄 $1\033[0m"
}

function ok {
  echo -e "\033[94m🎽 $1\033[0m"
}

fail() {
  echo -e "\033[90m✖️  $1\033[0m"
}

# tput_colors - Demonstrate color combinations.
function colors-tput(){
    for fg_color in {0..7}; do
        set_foreground=$(tput setaf $fg_color)
        for bg_color in {0..7}; do
            set_background=$(tput setab $bg_color)
            echo -n $set_background$set_foreground
            printf ' F:%s B:%s ' $fg_color $bg_color
        done
        echo $(tput sgr0)
    done
}

# ANSI escape codes
function colors-ANSI() {
    echo -E "\033[字背景颜色;字体颜色m字符串\033[0m"
    # for code ({000..255}) print -P -- "$code : %F{$code}Winter is coming"
    echo "字颜色"

    for code ({30..37}) echo -e "$code \033[0;$code;5m FBI WARNING \033[0m"

    echo "背景颜色"

    for code ({40..47}) echo -e "$code \033[$code;5m FBI WARNING \033[0m"
    echo "字加亮颜色"

    for code ({90..97}) echo -e "$code \033[$code;5m FBI WARNING \033[0m"
    echo "背景加亮颜色"

    for code ({100..107}) echo -e "$code \033[$code;5m FBI WARNING \033[0m"
}

# Java
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