#!/bin/bash
###
 # @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 # @Date: 2024-09-29 14:34:38
 # @LastEditors: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 # @LastEditTime: 2024-09-29 14:44:37
 # @FilePath: \linux-auto-shell\docker-auto-ssh.sh
 # @Description: 
 # 
 # Copyright (c) 2024 by ${git_name_email}, All Rights Reserved. 
### 

# 更新包列表并安装SSH
echo "正在更新包列表..."
apt-get update && echo "更新完成！" || { echo "更新失败！"; exit 1; }
echo "正在安装SSH..."
apt-get install -y ssh && echo "SSH安装完成！" || { echo "SSH安装失败！"; exit 1; }
apt-get install -y vim && echo "Vim安装完成！" || { echo "Vim安装失败！"; exit 1; }

# 修改sshd_config文件
echo "正在修改sshd_config文件..."
sed -i.bak 's/^#*PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && echo "sshd_config文件修改完成！" || { echo "修改失败！"; exit 1; }

# 创建.ssh目录
echo "正在创建.ssh目录..."
mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo ".ssh目录创建完成！" || { echo "创建.ssh目录失败！"; exit 1; }

# 添加公钥到authorized_keys
echo "正在添加公钥到authorized_keys..."
if ! grep -q "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBR4m/9eUv5tOrTDlNZX7+by09kOI4r8tqSldHFCWFjYJ/ixlCz0yqpGUx4RbX++YBN91XszYCp0/k9jhimqDnq8ETw8kh1tEdJI5Qw01yItT6f2LyBaZ6yoN+1riJ4KH+4jRryVSwPqyIlnrs/V3JLkfa1y504EBo9rJ/mOl5ZjM6UoGsb0Seqfh30wBE4C9Jk8hG7hchx1V1cmOlMcLzrvc3sNFbkHMp3lwQ6oPziLmWU41kgQE46dkIHvmS1XBWhNLa4j6L1yDessAf8YDHwhPqmAaG6jA0lqMqXjAjTZctrZslDey21Za5T0T5bmqvGBPbYsLjMvmgzEtzYZlSAx9Lm3xQ3AGtRwU2unAag44G97S+9a1ZysHcDzi+BgrdWZSB/r15w6/E23dfUO9Gax8k18HzklngnN8lvIawpyKKjuXtp52+IBIdgJhIa2njv9lbzhW+Ry1Upz3WulirAtcUVsK/JIV1ImyQ5rvyRi+oi5SLAE71wuomUuB6uU0=" ~/.ssh/authorized_keys; then
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBR4m/9eUv5tOrTDlNZX7+by09kOI4r8tqSldHFCWFjYJ/ixlCz0yqpGUx4RbX++YBN91XszYCp0/k9jhimqDnq8ETw8kh1tEdJI5Qw01yItT6f2LyBaZ6yoN+1riJ4KH+4jRryVSwPqyIlnrs/V3JLkfa1y504EBo9rJ/mOl5ZjM6UoGsb0Seqfh30wBE4C9Jk8hG7hchx1V1cmOlMcLzrvc3sNFbkHMp3lwQ6oPziLmWU41kgQE46dkIHvmS1XBWhNLa4j6L1yDessAf8YDHwhPqmAaG6jA0lqMqXjAjTZctrZslDey21Za5T0T5bmqvGBPbYsLjMvmgzEtzYZlSAx9Lm3xQ3AGtRwU2unAag44G97S+9a1ZysHcDzi+BgrdWZSB/r15w6/E23dfUO9Gax8k18HzklngnN8lvIawpyKKjuXtp52+IBIdgJhIa2njv9lbzhW+Ry1Upz3WulirAtcUVsK/JIV1ImyQ5rvyRi+oi5SLAE71wuomUuB6uU0= zq-magicbook@DESKTOP-BMJEEHS" >> ~/.ssh/authorized_keys && echo "公钥添加完成！" || { echo "公钥添加失败！"; exit 1; }
else
    echo "公钥已存在，跳过添加。"
fi

# 设置authorized_keys权限
echo "正在设置authorized_keys权限..."
chmod 600 ~/.ssh/authorized_keys && echo "权限设置完成！" || { echo "权限设置失败！"; exit 1; }

# 启动SSH服务
echo "正在启动SSH服务..."
service ssh start && echo "SSH服务重启完成！" || { echo "重启失败！"; exit 1; }

# 在.bashrc末尾添加如下代码
echo "service ssh start" | tee -a /root/.bashrc

echo "SSH安装和配置全部完成！"
