---
title: Saas公有化部署指南
description: 
published: true
date: 2024-08-06T11:42:34.660Z
tags: 
editor: markdown
dateCreated: 2024-08-06T10:07:39.912Z
---

# Saas公有化部署
目录

- 一.SaaS公有化部署介绍
- 1.1概述
- 1.2 支持硬件
- 1.3 支持系统
- 二.SaaS公有化部署
- 2.1 前提准备
- 2.2 Compose方式安装
- 2.3 Saas用户添加
- 2.4 Windows客户端配置
- 2.5常见错误处理方法

# 一.SaaS公有化部署介绍
## 1.1 概述
对于飞鼠NAT组网的非中心控制器部署模式做出系统的部署教程。客户端可覆盖至Linux、Macos、Windows、IOS与Android。本文档主要介绍Linux与Windows的部署操作。
## 1.2 支持硬件
支持各大主流平台，详细测试如下。
| 系统 | 典型配置 | 是否支持飞鼠 | 测试问题 |
|:-----:|:-----:|:-----:|:-----:|
| Arm Linux  | 4C/8C 2G/1G  | 是  | 无 |
| X86 Linux  | 无  | 是  | 无 |
| Pve Lxc Linux | 无 | 否 | 半虚拟化网卡存在问题，无法启动 |
| Mips Linux | 3A3000/4000 | 否 | 不定时掉线 |
| LoongArch Linux | 3A5000 | 是 | 无 |
| IOS | 无 | 是 | 仅支持客户端 |
| 安卓 | 无 | 是 | 仅支持客户端 |
| 飞腾/鲲鹏/海思 | FT2000/920/Hi1616 | 是 | 无 |
| Windows | 无 | 是 | 仅支持客户端 |
| OpenWrt | MT7988 | 是 | 视内存而定 |
## 1.3 支持系统
需基于Debian10及以后内核Linux部署，不支持半虚拟化如lxc类容器内嵌套部署。

# 二.SAAS公有化部署
## 2.1 前提准备
针对Ubuntu类系统，需要关闭或设置防火墙通行。
执行以下命令关闭防火墙
`sudo systemctl disable ufw.service`
针对Debian类系统，无需进行特殊操作。
对于VPS部署用户，参照VPS服务商的防火墙放行。
放行端口如下
| 作用 | 类型 | 端口 | 备注 |
|:-----:|:-----:|:-----:|:-----:|
| 网页通信 | TCP | 9091 | 用于Webui配置 |
安装Docker
`wget https://dow.feishuwg.com/get-docker.sh`
`sudo sh get-docker.sh --mirror Aliyun`
安装完成后查询Docker版本
`docker version`
返回信息如下
![paht5q.png](/Saas/paht5q.png)
确认满足运行条件
## 2.2 Compose方式安装
安装Dokcer-compose
`sudo apt install docker-compose`
下载compose文件
`wget https://dow.feishuwg.com/p2p/docker-compose.yaml`

执行compose文件
`sudo docker compose up -d`
系统将会自动部署飞鼠NAT组网节点端。
等待执行完毕后，进入组网管理界面，
输入服务器ip:9091
![pahu9k.png](/Saas/pahu9k.png)
部署成功
## 2.3 SaaS平台用户添加
在浏览器中输入网址 https://www.feishunet.com/
注册账号后，进入主界面。
单击右上角 网络创建
依据自身情况填写相关信息
![图片1.png](/Saas/图片1.png)
![图片2.png](/Saas/图片2.png)
添加完成后，进入区域管理添加设备
![图片3.png](/Saas/图片3.png)
可获得识别码（唯一组网标识码），将其粘贴至客户端中，点击连接
![图片4.png](/Saas/图片4.png)
连接成功后，会显示连接设备，此时Linux服务端连接成功。
![pahuic.png](/Saas/pahuic.png)
## 2.4 Windows客户端配置
返回SaaS平台，重新添加用户，复制密钥。
在https://dow.feishuwg.com下载Windows客户端
![图片5.png](/Saas/图片5.png)
下载解压后右键以管理员权限运行，在右下角状态栏中右键飞鼠图标打开控制面板。
![pahyxu.png](/Saas/pahyxu.png)
输入token后连接
![pahvq9.png](/Saas/pahvq9.png)
等待打洞后解析成功，交互带宽即为实际上传带宽。
## 2.5 常见错误处理方法
类似于输入ip:9091后无法访问的，可能是部署主机存在端口占用情况。
飞鼠针对此种情况会自动处理，即选择一个未使用端口进行映射，查询方法如下。
`sudo docker ps -a` #查看所有容器
`sudo docker logs -f p2p-feishu-1` #p2p-feishu-1为输出的实际容器名称
输出如下
![pahuuz.png](/Saas/pahuuz.png)
此种情况下，即启用了10066端口。