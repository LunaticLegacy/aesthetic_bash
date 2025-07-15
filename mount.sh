#!/bin/bash

# 染色
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # 重置颜色

# 定义一些常用标头
ERR_HEAD="[ ${RED}ERROR${NC} ]"
INFO_HEAD="[ ${GREEN}INFO${NC} ]"

set -e  # 遇错退出

# 确保脚本以root身份运行
if [ "$(id -u)" != "0" ]; then
    printf "${ERR_HEAD} This script must be run as root or sudo mode.\n" >&2
    exit 1
fi

# 定义变量。
IMAGE="./target.img"    # 你要挂载的镜像位置。
BOOT_MOUNT="./boot"     # 操作系统引导挂载点位置。
ROOTFS_MOUNT="./rootfs" # 根文件系统挂载点位置。

# 创建挂载点（如果不存在）
mkdir -p "$BOOT_MOUNT" "$ROOTFS_MOUNT"

# 定义清理函数。
cleanup() {
    printf "${INFO_HEAD} Cleaning up...\n"
    umount "$BOOT_MOUNT" 2>/dev/null || true
    umount "$ROOTFS_MOUNT" 2>/dev/null || true
    if [ -n "$LOOP_DEV" ]; then
        losetup -d "$LOOP_DEV" 2>/dev/null || true
        printf "${INFO_HEAD} $LOOP_DEV has been detached.\n"
    fi
    exit 1
}

# 捕获错误和信号，在捕获到时运行清理函数。
trap cleanup ERR INT

# 找到一个可用的loop设备并绑定映像
LOOP_DEV=$(losetup -f)
if [ -z "$LOOP_DEV" ]; then
    printf "${ERR_HEAD} No available loop device found.\n" >&2
    exit 1
fi

losetup -P "$LOOP_DEV" "$IMAGE"
printf "${INFO_HEAD} Using $LOOP_DEV as loop device.\n"

# 挂载分区
printf "${INFO_HEAD} Mounting ${LOOP_DEV}p1 to $BOOT_MOUNT\n"
mount "${LOOP_DEV}p1" "$BOOT_MOUNT"

printf "${INFO_HEAD} Mounting ${LOOP_DEV}p2 to $ROOTFS_MOUNT\n"
mount "${LOOP_DEV}p2" "$ROOTFS_MOUNT"

printf "${INFO_HEAD} Mount successful. You can now access to the mounted partitions.\n"

