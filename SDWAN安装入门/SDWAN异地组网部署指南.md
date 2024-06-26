---
title: 安装飞鼠
description: 飞鼠的中心控制器和节点安装
published: true
date: 2024-06-08T11:13:38.882Z
tags: 
editor: markdown
dateCreated: 2023-09-25T12:41:31.836Z
---

# SDWAN异地组网部署指南

#### 一、产品概述

​	飞鼠科技提供的异地组网工具是一种用于构建远程网络连接的实用工具。它可以帮助用户在互联网上建立安全的、高效的远程连接，从而实现远程办公、远程会议、远程教育等应用场景。本教程将介绍异地组网工具的部署和使用方法。

#### 二、部署步骤

+ ★★★★★★须知★★★★★★

​	本教程使用Ubuntu系统，进行部署安装。

★★★★★★开始★★★★★★

##### 第一步：检查系统版本及内核版本

```bash
1.检查当前系统版本，使用命令：
方法一
lsb_release -a
方法二
cat /etc/redhat-release

2.检查当前系统内核，使用命令：
方法一
uname -a
方法二
cat /proc/version

注：请使用符合部署条件的系统进行部署安装，当系统需要升级或重装系统时，请备份重要数据。
```

##### 第二步：检查工具必需使用的端口的状态

| 作用       | 类型 | 协议        | 备注                               |
| ---------- | ---- | ----------- | ---------------------------------- |
| 网页访问   | tcp  | 8088        | master必开                         |
| Socket通信 | tcp  | 8095        | master必开                         |
| SD-WAN通信 | udp  | 50000-51000 | master必开，路由节点、子网节点必开 |

解释：

Socket通信：套接字(Socket)，就是对网络中不同主机上的应用进程之间进行双向通信的端点的中间层，有三个步骤：服务器监听，客户端请求，连接确认。

SD-WAN通信：SD-WAN提供了基于SDN数据中心的企业分支办公室在广域网中的解决方案。通过部署SDN和SD-WAN，可以虚拟化资源，加速合作伙伴的网络服务分发，更好的性能和改善可用性，自动网络部署和管理，已达到减少客户的花费。

# 注意事项
## 目前只推荐安装Ubuntu，18.04，20.04，22.04  

# 1.前期准备工作

## 开启内核转发
编辑 `vi /etc/sysctl.conf`， 将
```bash
net.ipv4.ip_forward = 1  
net.ipv6.conf.all.forwarding = 1
```

添加并保存 然后 `sysctl -p` 使其生效。  
查看是否成功：`sysctl net.ipv4.ip_forward`
如果返回为“net.ipv4.ip_forward = 1”则表示成功 sysctl 

#手动执行（可选）否则需要重启主机
`sudo iptables -P FORWARD ACCEPT`
## 关闭防火墙
- 1.使用`systemctl stop ufw`关闭防火墙。
- 2.使用`sudo systemctl disable ufw`设置开机不启动防火墙
- 3.`sudo ufw status` 查看防火墙状态：inactive是关闭，active是开启
## 安装docker 
需要提前安装docker、docker-compose;
```bash
# 执行安装
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
```



# 2.安装工具
## 类型分为中心控制器、路由节点、子网节点
- 中心控制器 ：完全有公网ip地址，用于控制所有节点通信转发
- 路由节点：可以是第二个数据中心要求有公网，用于冗余
- 子网节点：不要求公网，用于下级局域网之间通信
## 安装中心控制器
粘贴compose.yaml文件，修改数据库设置为自己想要的密码，直接`docker compose up -d`启动
* compose安装方式不同启动方式不同老版本`docker-compose up -d`新版本用`docker compose up -d`
```yaml
version: "3"
services:
 
  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: feishuwg
      POSTGRES_PASSWORD: m7576WDx8dunrjU2
      POSTGRES_USER: feishuuser
      TZ: Asia/Shanghai
    logging:
      driver: "none"
    restart: unless-stopped
    ports:
     - 5432:5432/tcp 
    volumes:
      - /data/feishu/pg:/var/lib/postgresql/data
  feishu:
    image: feishuwg/wg:arm
    cap_add:
      - ALL
    devices:
      - /dev/net/tun
    depends_on:
      - db
    environment:
      #POSTGRE-PATH: postgres://数据库用户名:数据库密码@数据库所在内网地址:端口/库
      POSTGRE-PATH: postgres://feishuuser:m7576WDx8dunrjU2@localhost:5432/feishuwg
      NODE_TYPE: master
    restart: always
    network_mode: host
    volumes:
      - /data/feishu/feishudb:/feishu/db/
      - /lib/modules:/lib/modules
```
## 安装其他节点（节点类型在中心控制器添加节点时选择）
```yaml
version: "3"
services:
  feishu:
    image: feishuwg/wg:arm
    cap_add:
      - ALL
    environment:
      NODE_TYPE: slave
    devices:
      - /dev/net/tun
    restart: always
    network_mode: host
    volumes:
      - /data/feishu/feishudb:/feishu/db/
      - /lib/modules:/lib/modules
```

# 访问地址
https://ip:8088  
默认账号密码：`admin`,`admin@123!`

# 地址设置示例
## 中心控制器
控制中心-修改中心控制器
* 起始端口：50000
* 对外网络地址：https://这里写自己的域名或者ip地址.cn:8088
## 路由节点
* 控制中心-从节点配置-公网ip：111.222.55.111 #！注意这里不带端口，中心控制器有端口
## 子网节点
* 无需设置从节点
