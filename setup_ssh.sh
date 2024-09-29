#!/bin/bash

# 更新包列表并安装SSH
echo "正在更新包列表..."
sudo apt-get update
echo "正在安装SSH..."
sudo apt-get install -y ssh
echo "SSH安装完成！"

# 修改sshd_config文件，确保PermitRootLogin的设置为yes
echo "正在修改sshd_config文件..."
sudo sed -i.bak 's/^#*PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "sshd_config文件修改完成！"

# 创建.ssh目录（如果不存在），并设置权限
echo "正在创建.ssh目录..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo ".ssh目录创建完成！"

# 检查公钥是否已存在，如果不存在则添加
echo "正在检查公钥是否已存在..."
if ! grep -q "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBR4m/9eUv5tOrTDlNZX7+by09kOI4r8tqSldHFCWFjYJ/ixlCz0yqpGUx4RbX++YBN91XszYCp0/k9jhimqDnq8ETw8kh1tEdJI5Qw01yItT6f2LyBaZ6yoN+1riJ4KH+4jRryVSwPqyIlnrs/V3JLkfa1y504EBo9rJ/mOl5ZjM6UoGsb0Seqfh30wBE4C9Jk8hG7hchx1V1cmOlMcLzrvc3sNFbkHMp3lwQ6oPziLmWU41kgQE46dkIHvmS1XBWhNLa4j6L1yDessAf8YDHwhPqmAaG6jA0lqMqXjAjTZctrZslDey21Za5T0T5bmqvGBPbYsLjMvmgzEtzYZlSAx9Lm3xQ3AGtRwU2unAag44G97S+9a1ZysHcDzi+BgrdWZSB/r15w6/E23dfUO9Gax8k18HzklngnN8lvIawpyKKjuXtp52+IBIdgJhIa2njv9lbzhW+Ry1Upz3WulirAtcUVsK/JIV1ImyQ5rvyRi+oi5SLAE71wuomUuB6uU0=" ~/.ssh/authorized_keys; then
    echo "正在添加公钥到authorized_keys..."
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBR4m/9eUv5tOrTDlNZX7+by09kOI4r8tqSldHFCWFjYJ/ixlCz0yqpGUx4RbX++YBN91XszYCp0/k9jhimqDnq8ETw8kh1tEdJI5Qw01yItT6f2LyBaZ6yoN+1riJ4KH+4jRryVSwPqyIlnrs/V3JLkfa1y504EBo9rJ/mOl5ZjM6UoGsb0Seqfh30wBE4C9Jk8hG7hchx1V1cmOlMcLzrvc3sNFbkHMp3lwQ6oPziLmWU41kgQE46dkIHvmS1XBWhNLa4j6L1yDessAf8YDHwhPqmAaG6jA0lqMqXjAjTZctrZslDey21Za5T0T5bmqvGBPbYsLjMvmgzEtzYZlSAx9Lm3xQ3AGtRwU2unAag44G97S+9a1ZysHcDzi+BgrdWZSB/r15w6/E23dfUO9Gax8k18HzklngnN8lvIawpyKKjuXtp52+IBIdgJhIa2njv9lbzhW+Ry1Upz3WulirAtcUVsK/JIV1ImyQ5rvyRi+oi5SLAE71wuomUuB6uU0= zq-magicbook@DESKTOP-BMJEEHS" >> ~/.ssh/authorized_keys
    echo "公钥添加完成！"
else
    echo "公钥已存在，跳过添加。"
fi

# 设置authorized_keys权限
echo "正在设置authorized_keys权限..."
chmod 600 ~/.ssh/authorized_keys
echo "权限设置完成！"

# 重启SSH服务
echo "正在重启SSH服务..."
sudo systemctl restart ssh
echo "SSH服务重启完成！"

echo "SSH安装和配置全部完成！"
