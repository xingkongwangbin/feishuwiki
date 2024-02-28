```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: feishu-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: feishu
  template:
    metadata:
      labels:
        app: feishu
    spec:
      containers:
      - name: feishu
        image: registry.cn-qingdao.aliyuncs.com/feishuwg/p2p:latest
        securityContext:
          capabilities:
            add:
              - ALL
        env:
        - name: token
          value: "u3vs9AxkjTvi2bRSNWAmjv1V4cyh8m3ep/CNjDHQWckxf8asJKFCdTaOhcf/DVH2pMfeb+R0wIbQ4HgeHg8v+BBY620AQssIKnpZQX4BTXft6Is3c+Fc3uYUvN5ipSv1LIv8OVLOmaf1vuR+/sKKOQ=="
        - name: networkCard
          value: "ens160"
        volumeMounts:
        - name: config-volume
          mountPath: /data/feishu/conf
        securityContext:
          privileged: true
        devices:
        - name: tun-device
          devicePath: /dev/net/tun
      volumes:
      - name: config-volume
        hostPath:
          path: ./conf
      hostNetwork: true
```