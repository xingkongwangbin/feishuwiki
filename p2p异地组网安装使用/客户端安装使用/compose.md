

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
    image: registry.cn-qingdao.aliyuncs.com/feishuwg/p2p:v2.2
    cap_add:
      - ALL
    privileged: true
    environment: # 此token为客户端配置根据情况修改
      token: u3vs9AxkjTvi2bRSNWAmjv1V4cyh8m3ep/CNjDHQWckxf8asJKFCdTaOhcf/DVH2pMfeb+R0wIbQ4HgeHg8v+BBY620AQssIKnpZQX4BTXft6Is3c+Fc3uYUvN5ipSv1LIv8OVLOmaf1vuR+/sKKOQ==  
    volumes:
      - ./conf:/data/feishu/conf
    devices:
      - /dev/net/tun
    logging:
      driver: "json-file"
      options:
        max-size: "50m"
    restart: always
    network_mode: host
```
* compose安装方式不同启动方式不同老版本`docker-compose up -d`新版本用`docker compose up -d`
## 通过浏览器访问
* ip地址+port:9091  

### 类似如下地址
`http://192.168.3.104:9091`
* 默认无密码需要打开网页去单独设置密码
### 网页如下
![](images/2024-03-10-21-27-16.png)

## 相关可能用到的参数
### 查看连接状态
`docker logs p2p-feishu-1 | grep curl`执行结果命令查看和其他客户端通信状态
`curl localhost:9091/p2p | jq`类似命令在容器内执行查看和其他端点通信状态
### 查看日志
`docker logs -f p2p-feishu-1`
### 进入容器
`docker exec -it p2p-feishu-1 sh`