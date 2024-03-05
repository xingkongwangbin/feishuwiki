# docker一键启动方式
## 创建文件夹
* `mkdir p2p`
* `执行如下命令`
```bash
docker run -d \
  --name feishu-p2p \
  --cap-add=ALL \
  privileged: true \
  -v $(pwd)/conf:/data/feishu/conf \
  --device=/dev/net/tun \
  --restart=always \
  --network=host \
  registry.cn-qingdao.aliyuncs.com/feishuwg/p2p:latest
```