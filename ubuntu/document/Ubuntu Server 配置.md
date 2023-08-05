# Ubuntu Server 配置

## 1、 启用 root ssh 登录

编辑 ssh 配置文件： `vim /etc/ssh/sshd_config`
找到 `#PermitRootLogin prohibit-password `
复制一行，并编辑 `PermitRootLogin yes`
￼
执行命令重新启动服务：`service ssh restart` 

## 2 、添加清华源

备份 ubuntu server 的原来的源，执行命令：
`cp /etc/apt/sources.list /etc/apt/sources.list.bak`

编辑文件  `/etc/apt/sources.list` 将清华源的内容服务到文件中保存

[ubuntu | 镜像站使用帮助 | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/)

执行命令： `apt update && apt-upgrade` 更新命令

## 3 、修改并使用静态 IP

执行命令： route -n 查看当前 路由信息以及网关信息
```sh
root@master:~# route -n                                                                                         
Kernel IP routing table                                                                                         
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface                                   
0.0.0.0         172.16.95.2     0.0.0.0         UG    0      0        0 ens33                                   
172.16.95.0     0.0.0.0         255.255.255.0   U     0      0        0 ens33 
```
当前的网关地址为：172.16.95.2

备份原有的文件：
`cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak`

编辑文件：
`vim /etc/netplan/00-installer-config.yaml`

输入以下内容：

```sh
network:                                                                                                        
  ethernets:                                                                                                    
    ens33:                                                                                                      
      dhcp4: no    #关闭dhcp                                                                                             
      addresses: [172.16.95.137/24] # 配置静态ip，并配置子网掩码                                                                             
      optional: true                                                                                            
      gateway4: 172.16.95.2            # 配置网关， 使用上面的网关                                                                         
      nameservers:                                                                                              
        addresses: [114.114.114.114]         # 配置dns                                                                   
  version: 2 
```

## 4、查看 Ubuntu 的版本号

```sh
root@master:# lsb_release -a                                                                         
No LSB modules are available.                                                                                   
Distributor ID: Ubuntu                                                                                          
Description:    Ubuntu 22.04.2 LTS                                                                              
Release:        22.04                                                                                           
Codename:       jammy 
```
## 5 修改服务器的时区

执行 命令 `date -R ` 查看时区是否正确

先将服务器的时区文件备份下：

` cp /etc/localtime /etc/localtime.bak`

执行命令 `tzselect` 目的是生成一个时区的文件： 

命令执行完成后拷贝文件：

`cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`

最后我们将服务器时间同步下服务器时间:

`ntpdate time.windows.com` 

`cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`

