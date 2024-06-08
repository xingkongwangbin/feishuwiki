---
title: 私有化安装
description: 私有化安装
published: true
date: 2023-12-18T09:16:30.990Z
tags: 
editor: markdown
dateCreated: 2023-10-29T09:03:02.605Z
---
# 产品概述
* 飞鼠提供的异地组网工具是一种用于构建远程网络连接的实用工具。它可以帮助用户在互联网上建立安全的、高效的远程连接，从而实现远程办公、远程会议、远程教育等应用场景。本教程将介绍异地组网工具的部署和使用方法。
* 飞鼠打洞可以实现快速的nat4穿越，极大的成功率
* 实测移动宽带nat4也可以打通
# 安装服务端
## 检查端口
| 作用       | 类型 | 协议        | 备注                               |
| ---------- | ---- | ----------- | ---------------------------------- |
| 网页访问   | tcp  | 8088        | 用于填写一些服务器信息                |
| Socket通信 | tcp  | 39577       | 用于socket通信下发配置信息            |

## 安装docker、docker compose
需要提前安装docker、docker-compose;
```bash
# 执行安装
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
```
## 下载容器镜像
docker pull registry.cn-qingdao.aliyuncs.com/feishuwg/wg:24.02.28
## 下载compose文件并且启动
```bash
mkdir feishu
cd feishu
wget https://dow.feishuwg.com/sdwan/docker-compose.yaml
#！！！注意单独执行
docker compose up -d
```
### 也可以直接复制如下的配置文件启动
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
      TZ: Asia/Shanghai #TZ表示服务器所在的时区
      PGTZ: Asia/Shanghai #而PGTZ表示数据库使用的时区。
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
      - /data/feishu/data:/feishu/data/
      - /lib/modules:/lib/modules
```

# 配置服务端
## 访问地址
https://ip:8088  
默认账号密码：`admin`,`admin@123!`
## 配置服务地址以及端口
* 打洞测试-中继服务设置
* 服务器ip：设置为你的云服务器地址或者域名
* 中继地址ip：设置为中继地址`例子为:115.227.19.84`
* 中继服务端口号：同上 `例子为:8001`
* 端口号：本机服务端口号
* 中继id：中继地址唯一id  `例子为:QmbaLkSVNUhn8wHKsi8U1GPAisUBxhwDA69zD8kmpHeyoL`
### 类似如图
![alt text](image.png)
## 创建区域
* 区域名称：自己起一个区域名字
* 备注：备注
* 区域ip段：虚拟ip地址段，类似`10.8.5.0/24`
#



# 内核优化
vi /etc/security/limits.conf
* soft nofile 1024
* hard nofile 65535

vi /etc/pam.d/login
session required /lib/security/pam_limits.so
#如果是64bit系统的话，应该为 :
session required /lib64/security/pam_limits.so

vi /etc/sysctl.conf
```
net.ipv4.ip_local_port_range = 1024 65535
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_rmem=4096 87380 16777216
net.ipv4.tcp_wmem=4096 65536 16777216
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_window_scaling = 0
net.ipv4.tcp_sack = 0
net.core.netdev_max_backlog = 30000
net.ipv4.tcp_no_metrics_save=1
net.core.somaxconn = 262144
net.ipv4.tcp_syncookies = 0
net.ipv4.tcp_max_orphans = 262144
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
```
查看当前有多少个TCP连接到当前服务器命令:netstat -antp |grep -i est |wc -l