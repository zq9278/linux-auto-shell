#!/bin/bash

# 备份原来的 sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 选择国内源（默认使用阿里云）
MIRROR="mirrors.aliyun.com"

echo "请选择要使用的国内源：
1) 阿里云 (mirrors.aliyun.com)
2) 清华大学 (mirrors.tuna.tsinghua.edu.cn)
3) 华为 (repo.huaweicloud.com)
4) 网易 (mirrors.163.com)
5) 北京外国语大学 (mirrors.bfsu.edu.cn)
6) 中科大 (mirrors.ustc.edu.cn)
7) 自动检测最快源（推荐）"

read -p "输入选项 (默认: 1): " choice

case $choice in
    2) MIRROR="mirrors.tuna.tsinghua.edu.cn" ;;
    3) MIRROR="repo.huaweicloud.com" ;;
    4) MIRROR="mirrors.163.com" ;;
    5) MIRROR="mirrors.bfsu.edu.cn" ;;
    6) MIRROR="mirrors.ustc.edu.cn" ;;
    7) 
        echo "正在测试最快的源..."
        best_mirror=$(curl -s https://raw.githubusercontent.com/icyz/LinuxMirrors/main/ubuntu.sh | bash)
        if [ -n "$best_mirror" ]; then
            MIRROR=$best_mirror
        else
            echo "自动检测失败，使用阿里云"
            MIRROR="mirrors.aliyun.com"
        fi
        ;;
    *) MIRROR="mirrors.aliyun.com" ;;
esac

# 检测是否运行在 Docker 容器中
if [ -f /.dockerenv ]; then
    echo "检测到 Docker 容器环境，使用 /etc/os-release 获取 Ubuntu 版本..."
    UBUNTU_VERSION=$(awk -F= '/VERSION_CODENAME/{print $2}' /etc/os-release)
else
    echo "检测到普通 Linux 服务器环境，使用 lsb_release 获取 Ubuntu 版本..."
    UBUNTU_VERSION=$(lsb_release -cs)
fi

# 如果仍然没有获取到版本号，则默认使用 focal（Ubuntu 20.04）
if [ -z "$UBUNTU_VERSION" ]; then
    echo "无法检测 Ubuntu 版本，默认使用 focal"
    UBUNTU_VERSION="focal"
fi

# 修改 sources.list
cat <<EOF | tee /etc/apt/sources.list
deb http://$MIRROR/ubuntu/ $UBUNTU_VERSION main restricted universe multiverse
deb http://$MIRROR/ubuntu/ $UBUNTU_VERSION-updates main restricted universe multiverse
deb http://$MIRROR/ubuntu/ $UBUNTU_VERSION-backports main restricted universe multiverse
deb http://$MIRROR/ubuntu/ $UBUNTU_VERSION-security main restricted universe multiverse
EOF

echo "国内源已切换为: $MIRROR"
echo "更新软件包列表..."
apt update
