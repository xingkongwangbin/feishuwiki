---
title: Saas公有化部署指南
description: 
published: true
date: 2024-08-06T11:08:31.733Z
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
## 1.1概述
对于飞鼠NAT组网的非中心控制器部署模式做出系统的部署教程。客户端可覆盖至Linux、Macos、Windows、IOS与Android。本文档主要介绍Linux与Windows的部署操作。
## 1.2支持硬件
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
## 1.3支持系统
需基于Debian10及以后内核Linux部署，不支持半虚拟化如lxc类容器内嵌套部署。

## 二.SAAS公有化部署
# 2.1前提准备
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
`wget https://dow.feishuwg.com/get-docker.sh
sudo sh get-docker.sh --mirror Aliyun`
安装完成后查询Docker版本
`docker version`
返回信息如下
![返回信息](http://zhengran.top:40061/i/2024/08/06/paht5q.png)