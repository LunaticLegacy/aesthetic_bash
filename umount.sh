#!/bin/bash

# 染色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # 重置颜色

# 定义一些常用标头
ERR_HEAD="[ ${RED}ERROR${NC} ]"
INFO_HEAD="[ ${GREEN}INFO${NC} ]"
WARN_HEAD="[ ${YELLOW}WARNING${NC} ]"

set -e  # 出现错误立即退出

# 定义变量。
IMAGE="./target.img"        # 你已经挂载的镜像位置。
BOOT_MOUNT="./boot"         # 引导挂载点位置。
ROOTFS_MOUNT="./rootfs"     # 根文件系统挂载点位置。

# 确保脚本以root身份运行
if [ "$(id -u)" != "0" ]; then
    printf "${ERR_HEAD} This script must be run as root or sudo mode.\n" >&2
    exit 1
fi

# 尝试查找与映像绑定的loop设备
LOOP_DEV=$(losetup -j "$IMAGE" | cut -d: -f1)

if [ -z "$LOOP_DEV" ]; then
    printf "${ERR_HEAD} No loop device is currently attached to $IMAGE.\n" >&2
    exit 1
fi

printf "${INFO_HEAD} Found loop device: $LOOP_DEV\n"

# 卸载挂载点（如果已挂载）
if mountpoint -q "$BOOT_MOUNT"; then
    printf "${INFO_HEAD} Unmounting $BOOT_MOUNT\n"
    umount "$BOOT_MOUNT"
else
    printf "${WARN_HEAD} $BOOT_MOUNT is not mounted.\n"
fi

if mountpoint -q "$ROOTFS_MOUNT"; then
    printf "${INFO_HEAD} Unmounting $ROOTFS_MOUNT\n"
    umount "$ROOTFS_MOUNT"
else
    printf "${WARN_HEAD} $ROOTFS_MOUNT is not mounted.\n"
fi

# 卸载设备
losetup -d "$LOOP_DEV"
printf "${INFO_HEAD} Detached loop device $LOOP_DEV\n"

printf "${INFO_HEAD} Done.\n"
exit 0
