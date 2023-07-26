#!/bin/sh
set -e
# 卸载原有的 docker 相关
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
    sudo apt-get remove $pkg
done
# 使用apt存储库安装
## 设置存储库
### 更新apt软件包索引并安装软件包，以允许apt在HTTPS上使用存储库：
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y

### 添加Docker的官方GPG密钥：
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

### 使用以下命令设置存储库：
echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# 安装Docker引擎
## 更新apt软件包索引：
sudo apt-get update

## 安装Docker Engine、containerd和Docker Compose。
## 要安装最新版本，请运行：

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# 验证是否安装成功
docker -v

######
echo "success ~"
