---
title: p2p客户端安装使用
description: 
published: true
date: 2023-12-06T15:48:19.709Z
tags: 
editor: markdown
dateCreated: 2023-11-29T15:04:57.328Z
---



# compose文件

| 作用       | 类型 | 协议        | 备注                               |
| ---------- | ---- | ----------- | ---------------------------------- |
| 网页访问    | tcp  | 8091  | api端口                         |
| Socket通信 | tcp  |      | 密钥交换                       |
| udp中转   | udp  |        | 中继 |

## 适用于nas，路由器，arm设备，不适合直接运行在win中
## compose
```yaml
version: "3"
services:
  feishu:
    image: registry.cn-qingdao.aliyuncs.com/feishuwg/p2p:latest
    cap_add:
      - ALL
    environment:
      token: u3vs9AxkjTvi2bRSNWAmjv1V4cyh8m3ep/CNjDHQWckxf8asJKFCdTaOhcf/DVH2pMfeb+R0wIbQ4HgeHg8v+BBY620AQssIKnpZQX4BTXft6Is3c+Fc3uYUvN5ipSv1LIv8OVLOmaf1vuR+/sKKOQ==  # 此token为客户端配置根据情况修改
      networkCard: ens160 #适用于多网卡配置，填写物理网卡的名字
      ospf: y             #这里写是否启动ospf路由协议 y启动n关闭
      api: y              #是否启动api访问 y启动n关闭
    devices:
      - /dev/net/tun
    restart: always
    network_mode: host
```
* token此为token参数，由服务端分发
* networkCard#适用于多网卡配置，填写物理网卡的名字
* ospf  #这里写是否启动ospf路由协议，Y启动n关闭
## 相关可能用到的参数
`curl localhost:8091/p2p | jq`用于查看其他客户端状态