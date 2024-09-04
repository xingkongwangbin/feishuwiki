---
title: nas安装使用
description: 
published: true
date: 2024-09-04T07:32:48.664Z
tags: 
editor: markdown
dateCreated: 2024-07-15T16:28:17.537Z
---

# 群晖
## ssh连接到群晖命令行
## 一定要管理员账户
## 创建tun网卡
```bash
# 创建一个持久的 TUN

#快捷编写脚本到路径: /usr/local/etc/rc.d/tun.sh 这将使得 /dev/net/tun 在启动时调用

echo -e '#!/bin/sh' >> /usr/local/etc/rc.d/tun.sh
echo -e 'insmod /lib/modules/tun.ko' > /usr/local/etc/rc.d/tun.sh

#给这段脚本添加权限（其实应该先vi这个空的脚本，然后添加权限，最后在写入上面的脚本内容，不然会提示你readonly）
chmod a+x /usr/local/etc/rc.d/tun.sh
#运行脚本：
/usr/local/etc/rc.d/tun.sh

#检查TUN的运行状态（可选）：
ls /dev/net/tun
/dev/net/tun
```
## docker-compose 安装
```bash
# 找一个自己经常放东西的目录，建议放到数据盘，创建一个文件夹叫p2p
mkdir p2p
# 切换到这个文件夹  
cd p2p
# 创建映射到容器内的文件
mkdir conf
mkdir logs
# 执行这两个下载分别是下载配置文件和更新文件
wget https://dow.feishunet.com/p2p/docker-compose.yaml
wget https://dow.feishunet.com/p2p/st.sh


```
## 启动
```bash
# 给st文件启动权限
chmod +x st.sh
# 启动飞鼠docker compose
sh st.sh
```

# 威联通与铁威马
## 创建tun网卡
**威联通需套件安装qvpn**  
**之后按照群晖的docker-compose安装即可**


# 疑难解答
## 启动之后无法访问网页但是容器正常 
> 找到对应的端口号，然后查看防火墙  

** `netstat -lntp | grep feishu` **
