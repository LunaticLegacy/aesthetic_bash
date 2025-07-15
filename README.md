# aesthetic_bash
对于一些写bash脚本不打颜色的吐槽而已，以及提供一个写颜色脚本的示例。`还有自己刚刚写出的颜色标头`。

**摸鱼产物**。

## 使用方法：
将[color_header.sh](color_header.sh)里的标头复制粘贴到你的文件，然后按示例进行即可。我个人喜欢使用printf而不是echo作为输出方法。

或者，干脆复制这个到你的文件里（可以选择复制其中一部分）：
```bash
# 重置颜色
NC='\033[0m'        # 关闭所有属性，恢复默认

# 常规前景色
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# 亮色前景色（加粗/高亮）
BOLD_BLACK='\033[1;30m'   # 灰色
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_MAGENTA='\033[1;35m'
BOLD_CYAN='\033[1;36m'
BOLD_WHITE='\033[1;37m'

# 背景色（一般用得少）
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_MAGENTA='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# 恢复背景颜色
BG_RESET='\033[0m'

# 下划线
UNDERLINE='\033[4m'
UNDERLINE_RESET='\033[24m'

# 反色
REVERSE='\033[7m'
REVERSE_RESET='\033[27m'

# 闪烁（有些终端可能不支持）
BLINK='\033[5m'
BLINK_RESET='\033[25m'

# 常用日志标头，配色丰富一些。注意这些标头依赖bold颜色，对应地拷贝过去。
ERR_HEAD="[ ${BOLD_RED}ERROR${NC} ]"
WARN_HEAD="[ ${BOLD_YELLOW}WARNING${NC} ]"
INFO_HEAD="[ ${BOLD_GREEN}INFO${NC} ]"
DEBUG_HEAD="[ ${BOLD_CYAN}DEBUG${NC} ]"
NOTICE_HEAD="[ ${BOLD_BLUE}NOTICE${NC} ]"
SUCCESS_HEAD="[ ${BOLD_GREEN}SUCCESS${NC} ]"
FAIL_HEAD="[ ${BOLD_RED}FAIL${NC} ]"
QUESTION_HEAD="[ ${BOLD_MAGENTA}QUESTION${NC} ]"
HINT_HEAD="[ ${BOLD_WHITE}HINT${NC} ]"
```

然后，就可以这样食用：
```bash
printf "${ERR_HEAD} Here's an example of error header!\n"
printf "${WARN_HEAD} Here's an example of warning header!\n"
printf "${INFO_HEAD} Here's an example of info header!\n"
printf "${DEBUG_HEAD} Here's an example of debug header!\n"
printf "${NOTICE_HEAD} Here's an example of notice header!\n"
printf "${SUCCESS_HEAD} Here's an example of success header!\n"
printf "${FAIL_HEAD} Here's an example of fail header!\n"
printf "${QUESTION_HEAD} Here's an example of question header!\n"
printf "${HINT_HEAD} Here's an example of hint header!\n\n"

printf "${RED}This is a red text.${NC}\n"
printf "${GREEN}This is a green text.${NC}\n"
printf "${YELLOW}This is a yellow text.${NC}\n"
printf "${BLUE}This is a blue text.${NC}\n"
printf "${MAGENTA}This is a magenta text.${NC}\n"
printf "${CYAN}This is a cyan text.${NC}\n"
printf "${WHITE}This is a white text.${NC}\n"
printf "${BLACK}This is a black text.${NC}\n"
printf "${NC}This is a normal text.\n\n"
```
