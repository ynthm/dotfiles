# _COLUMNS=$(tput cols)
_COLUMNS=$COLUMNS
_MESSAGE=" FBI Warining "
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")

echo " "
# \033[开始 + 特效叠加;隔开 + m结尾
F_WHITE_B_RED='\033[1;41;97;5m' # 白字红背景 1粗体文本  5闪烁文本 41背景红色  97文字高亮白色
WHITE='\033[97m'
COLOR_OFF='\033[0m' # No Color 0常规文本  
echo -e "${spaces}${F_WHITE_B_RED} FBI WARNING ${COLOR_OFF}"
echo " "

_MESSAGE="Ferderal Law provides severe civil and criminal penalties for"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${WHITE}${_MESSAGE}${COLOR_OFF}"

_MESSAGE="the unauthorized reproduction, distribution, or exhibition of"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${WHITE}${_MESSAGE}${COLOR_OFF}"

_MESSAGE="copyrighted motion pictures (Title 17, United States Code,"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${WHITE}${_MESSAGE}${COLOR_OFF}"

_MESSAGE="Sections 501 and 508). The Federal Bureau of Investigation"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${WHITE}${_MESSAGE}${COLOR_OFF}"

_MESSAGE="investigates allegations of criminal copyright infringement"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${WHITE}${_MESSAGE}${COLOR_OFF}"

_MESSAGE="(Title 17, United States Code, Section 506)."
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${WHITE}${_MESSAGE}${COLOR_OFF}"
echo " "