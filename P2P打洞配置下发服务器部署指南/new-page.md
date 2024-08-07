---
title: 群晖DSM安装指南
description: 
published: true
date: 2024-08-07T07:22:47.485Z
tags: 
editor: markdown
dateCreated: 2024-08-07T06:58:07.631Z
---

# 群晖部署
## 概述
本文主要针对群晖客户在无公网IP下的NAT打洞部署说明，旨在帮助用户快速上手进行打洞组网。
## 目录
### 一 介绍
1.1概述
1.2 支持硬件
1.3 支持系统
### 二 部署
2.1 前提准备
2.2 Compose方式安装
2.3 Saas用户添加
2.4 Windows客户端配置
2.5 网关模式组网
2.6常见错误处理方法

## 一 介绍
### 1.1 概述
对于飞鼠NAT组网的非中心控制器部署模式做出群晖的部署教程。设备支持涵盖支持docker的群晖NAS
### 1.2 支持硬件
支持各大主流平台，详细测试如下。
| 系统 | 典型配置 | 是否支持飞鼠 | 测试问题 |
|:-----:|:-----:|:-----|:-----|
| 7.2 | ARM64 | 是 | 无 |
| 7.2 | X86_64 | 是 | 无 |
| 6.1/2 | ARM64/X86_64 | 否 | 系统内核缺少驱动 |

### 1.3支持系统
需系统DSM7及以后群晖NAS部署，同时支持ARM64与X86_64架构。

## 二 部署
### 2.1前提准备
需在套件中心中安装Container Manager
![图片1.png](/t1.png)
找到控制面板-终端机与SNMP
![t2.png](/t2.png)
单击启动SSH功能，应用。
![t3.png](/t3.png)
打开cmd，输入 ssh yourname@yourip
其中NAS的用户名为‘yourname’ ，NAS的内网地址为‘yourip’。
![t4.png](/t4.png)
此处为询问是否新任并记录ssh密钥，输入yes
![t5.png](/t5.png)
此处为输入密码环节，输入对应用户的密码。
![t6.png](/t6.png)
此即进入主界面
输入sudo -i 切换至root用户，密码即为NAS密码。
![t7.png](/t7.png)
输入 `echo -e '#!/bin/sh' >> /usr/local/etc/rc.d/tun.sh` #创建启动脚本
输入 `echo -e 'insmod /lib/modules/tun.ko' > /usr/local/etc/rc.d/tun.sh` #链接tun网卡
输入 `chmod a+x /usr/local/etc/rc.d/tun.sh` #赋权脚本
输入 `/usr/local/etc/rc.d/tun.sh` #运行脚本
![t8.png](/t8.png)
在filestation中找到想要安装飞鼠的文件夹
![t9.png](/t9.png)
在左侧文件目录名称处右键，单击属性
![t10.png](/t10.png)
记录下该目录的位置

### 2.2 Compose方式安装
（确保你已经是root权限）
本次测试机器的安装位置为 ‘/volume1/Test’ 
故在终端中输入 `cd /volume1/Test`
`mkdir p2p` #创建飞鼠配置存放目录
`cd p2p` #切换目录
`wget https://dow.feishunet.com/p2p/docker-compose.yaml`  #下载compose文件
`wget https://dow.feishunet.com/p2p/st.sh`  #下载更新脚本
`chmod +x st.sh` #赋权脚本
`sh st.sh` #启动脚本
![t11.png](/t11.png)
此即安装完成。
等待执行完毕后，进入组网管理界面，
输入NAS ip:9091
![t12.png](/t12.png)
部署成功

### 2.3 SaaS平台用户添加
在浏览器中输入网址 https://www.feishunet.com/
注册账号后，进入主界面。
单击右上角 网络创建
依据自身情况填写相关信息
![图片1.png](/图片1.png)
![图片2.png](/图片2.png)
添加完成后，进入区域管理添加设备
![图片3.png](/图片3.png)
可获得识别码（唯一组网标识码），将其粘贴至客户端中，点击连接
![图片4.png](/图片4.png)
连接成功后，会显示连接设备，此时Linux服务端连接成功。
![pahuic.png](/pahuic.png)

### 2.4 Windows客户端配置
返回SaaS平台，重新添加用户，复制密钥。
在https://dow.feishuwg.com下载Windows客户端
![图片5.png](/图片5.png)
下载解压后右键以管理员权限运行，在右下角状态栏中右键飞鼠图标打开控制面板。
![pahyxu.png](/pahyxu.png)
输入token后连接
![pahvq9.png](/pahvq9.png)
等待打洞后解析成功，交互带宽即为实际上传带宽。

### 2.5 网关方式组网
即通过组网设备访问该组网设备局域网内的其他设备的组网。
例：甲设备 192.168.1.X网段 组网ip为10.10.10.1
乙设备192.168.2.X网段 组网ip为10.10.10.2
令乙设备可以访问甲设备的192.168.1.X网段下的其他设备。
即需要配置路由模式。
打开Saas平台-组网管理-查看全部-查看路由
![t22.png](/t22.png)
单击‘创建路由’
![t23.png](/t23.png)
![t24.png](/t24.png)
网关机器 即通过哪台机器访问它所在的局域网
代理地址 填入局域网的CIDR地址。若想要访问的目标局域网地址为192.168.1.X，则填入192.168.1.0/24。
标签 区分哪台设备会经过路由，即选择标签后的设备可以访问目标局域网。
![t25.png](/t25.png)
此处即创建完成。
![t26.png](/t26.png)
单击‘查看网络’ 选择想要访问目标局域网的设备，在‘分组标签’中填入前文所设置的标签。（注意网关设备不需要填入标签。）
等待两分钟配置下发，即可访问目标局域网。

### 2.6 常见错误处理方法
类似于输入ip:9091后无法访问的，可能是部署主机存在端口占用情况。
飞鼠针对此种情况会自动处理，即选择一个未使用端口进行映射，查询方法如下。
`sudo docker ps -a` #查看所有容器
`sudo docker logs -f p2p-feishu-1` #p2p-feishu-1为输出的实际容器名称
输出如下
![pahuuz.png](/pahuuz.png)
此种情况下，即启用了10066端口。