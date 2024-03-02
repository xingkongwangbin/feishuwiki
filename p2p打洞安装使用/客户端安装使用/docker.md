# docker一键启动方式
## 创建文件夹
* `mkdir p2p`
* `执行如下命令`
```bash
docker run -d \
  --name feishu \
  --cap-add=ALL \
  -e token=u3vs9AxkjTvi2bRSNWAmjv1V4cyh8m3ep/CNjDHQWckxf8asJKFCdTaOhcf/DVH2pMfeb+R0wIbQ4HgeHg8v+BBY620AQssIKnpZQX4BTXft6Is3c+Fc3uYUvN5ipSv1LIv8OVLOmaf1vuR+/sKKOQ== \
  -v $(pwd)/conf:/data/feishu/conf \
  --device=/dev/net/tun \
  --restart=always \
  --network=host \
  registry.cn-qingdao.aliyuncs.com/feishuwg/p2p:latest
```