---
title: p2p客户端安装使用
description: 
published: true
date: 2023-12-18T13:53:50.994Z
tags: 
editor: markdown
dateCreated: 2023-11-29T15:04:57.328Z
---



# compose文件

| 作用       | 类型 | 协议        | 备注                               |
| ---------- | ---- | ----------- | ---------------------------------- |
| api访问    | tcp  |        | api端口                       |
| Socket通信 | tcp  |        | 密钥交换                       |
| udp中转    | udp  |        | 中继                         |

## 适用于nas，路由器，arm设备，不适合直接运行在win中
## compose
```yaml
version: "3"
services:
  feishu:
    image: registry.cn-qingdao.aliyuncs.com/feishuwg/p2p:latest
    cap_add:
      - ALL
    environment: # 此token为客户端配置根据情况修改
      token: u3vs9AxkjTvi2bRSNWAmjv1V4cyh8m3ep/CNjDHQWckxf8asJKFCdTaOhcf/DVH2pMfeb+R0wIbQ4HgeHg8v+BBY620AQssIKnpZQX4BTXft6Is3c+Fc3uYUvN5ipSv1LIv8OVLOmaf1vuR+/sKKOQ==  
      networkCard: ens160 #适用于多网卡配置，填写物理网卡的名字
    devices:
      - /dev/net/tun
    restart: always
    network_mode: host
```

## 相关可能用到的参数
### 查看连接状态
`docker logs p2p-feishu-1 | grep curl`执行结果命令查看和其他客户端通信状态
`curl localhost:38251/p2p | jq`在容器内执行查看和其他端点通信状态
### 查看日志
`docker logs -f p2p-feishu-1`