

# compose文件
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
    devices:
      - /dev/net/tun
    restart: always
    network_mode: host
```