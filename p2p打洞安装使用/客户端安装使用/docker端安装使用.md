

# compose文件

| 作用       | 类型 | 协议        | 备注                               |
| ---------- | ---- | ----------- | ---------------------------------- |
| api访问    | tcp  |        |                        |

## 适用于nas，路由器，arm设备，不适合直接运行在win中
## 安装docker 
需要提前安装docker、docker-compose;
```bash
# 执行安装
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
```
## compose
* `mkdir p2p`
* `vi compose.yaml`

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
    volumes:
      - ./conf:/data/feishu/conf
    devices:
      - /dev/net/tun
    restart: always
    network_mode: host
```
* compose安装方式不同启动方式不同老版本`docker-compose up -d`新版本用`docker compose up -d`
## 相关可能用到的参数
### 查看连接状态
`docker logs p2p-feishu-1 | grep curl`执行结果命令查看和其他客户端通信状态
`curl localhost:port/p2p | jq`类似命令在容器内执行查看和其他端点通信状态
### 查看日志
`docker logs -f p2p-feishu-1`
### 进入容器
`docker exec -it p2p-feishu-1 sh`