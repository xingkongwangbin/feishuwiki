# 群晖
## ssh连接到群晖命令行
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
mkdir p2p
cd p2p
wget https://dow.feishunet.com/p2p/docker-compose.yaml
wget https://dow.feishunet.com/p2p/st.sh
```
## 启动
```bash
chmod +x st.sh
sh st.sh
```

# 威联通
## 创建tun网卡
**套件安装qvpn**  
**之后按照群晖的docker-compose安装即可**
