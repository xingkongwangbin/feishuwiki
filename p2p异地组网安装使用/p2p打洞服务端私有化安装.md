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