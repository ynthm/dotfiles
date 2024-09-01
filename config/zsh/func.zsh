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
function jdk17(){
    setjdk 17
}
function java-v(){
    /usr/libexec/java_home -V
}

function preview(){
  FILE_NAME=$1
  IDX=1
  # 1 遍历到 10
  until [ ! $IDX -lt 10 ]
  do
    echo $IDX
    SEC=`expr $IDX \* 300`
    # 每隔 5 分钟
    echo $SEC
    ffmpeg -y -ss $SEC -i $FILE_NAME \
      -vcodec libwebp -vf "select='gt(scene,0.4)'" -frames 1 -q:v 2 -compression_level 6 img-$IDX.webp

    IDX=`expr $IDX + 1`
  done
}

# ffmpeg-avif 30 60 0 39 59 abc.mp4
# SS 开始时间(秒) 跳过片头
# GAP 间隔时间(秒)
function ffmpeg-avif(){
  SS=$1
  GAP=$2
  HOUR=$3
  MINUTE=$4
  SECOND=$5
  FILE_NAME=$6
  ((MAX_SECENDS=$HOUR*60, MAX_SECENDS = MAX_SECENDS*60, m=$MINUTE*60, MAX_SECENDS= MAX_SECENDS+m, MAX_SECENDS=MAX_SECENDS+$SECOND))
  # STEP=$(($MAX_SECENDS / $GAP))
  ((STEP=$MAX_SECENDS / $GAP, STEP=STEP+1))
  echo "总长 ${MAX_SECENDS}s $STEP 张"

  IDX=1
  SEC=$SS
  # 1 遍历到 10
  until [ ! $SEC -lt $MAX_SECENDS ]
  do
    echo "$IDX $SEC"
    ffmpeg -y -ss $SEC -i $FILE_NAME \
       -vf select="gt(scene\,0.3)",drawtext="box=1:boxborderw=10:boxcolor=black@0.3:fontsize=80:fontcolor=white:text='%{pts\:gmtime\:$SEC\:%H\\\\\:%M\\\\\:%S}':x=w-text_w-20:y=20" \
       -frames:v 1 -c:v libaom-av1 -crf 12 img_$IDX.avif || break
    ((h=$IDX * $GAP, SEC=$SS+h))
     IDX=`expr $IDX + 1`
  done
}