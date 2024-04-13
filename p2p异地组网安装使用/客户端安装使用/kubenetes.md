```yaml
# 定义一个Service，用于对外提供访问Feishu应用的统一入口
apiVersion: v1
kind: Service
metadata:
  name: feishu # 服务名称
spec:
  selector:
    app: feishu # 选择标签为app=feishu的Pod
  type: NodePort # Service类型为NodePort
  ports:
  - protocol: TCP # 协议类型为TCP
    port: 9091 # 定义服务端口为9091
    targetPort: 9091 # 定义Pod实际监听的端口为9091
    nodePort: 32368 # 定义NodePort为32368，可通过此端口从集群外访问服务
---
# 定义一个Deployment，用于管理Feishu应用的Pod副本集
apiVersion: apps/v1
kind: Deployment
metadata:
  name: feishu-deployment # 副本集名称
spec:
  replicas: 1 # 声明副本数为1
  selector:
    matchLabels:
      app: feishu # 选择标签为app=feishu的Pod
  template:
    metadata:
      labels:
        app: feishu # 为新创建的Pod设置标签为app=feishu
    spec:
      containers:
      - name: feishu # 容器名称
        image: registry.cn-qingdao.aliyuncs.com/feishuwg/p2p:latest # 指定容器使用的镜像及版本
        imagePullPolicy: IfNotPresent # 如果镜像已存在于本地则不拉取
        env: # 定义环境变量
        - name: token # 飞鼠的token，可以填写也可以删除去网页填写
          value: "PCSYrvOBqJmC/KtCnUYjoLBzEeE/iBeGdQsteRRJD//CEK0vrc643FrNwidp+UrIbAuAaK1byyXQMtwtuv7wf6QAPnGIgJoBhBhL74EtdSRaqma5xXDvs3zGGiedZbPUVbfNPc/XPETVc+gAnvlckbU1Y19y/11jSmUNrwDcVEQ="
        ports:
        - containerPort: 9091 # 容器监听的端口为9091
        resources: # 定义资源请求和限制
          requests:
            cpu: 2 # 请求的CPU资源为
            memory: 2Gi # 请求的内存资源为
          limits:
            cpu: 2 # 限制的CPU资源为
            memory: 2Gi # 限制的内存资源为
        securityContext: # 容器的安全上下文
          privileged: true # 启用特权模式
          capabilities: # 增加容器的系统能力
            add:
            - ALL # 添加所有系统能力
        readinessProbe: # 定义就绪探针
          tcpSocket: # 使用TCPSocket方式进行探针检查
            port: 9091 # 检查的端口为9091
          initialDelaySeconds: 5 # 初次延迟时间为5秒
          periodSeconds: 10 # 检查间隔时间为10秒
        livenessProbe: # 定义存活探针
          tcpSocket: # 使用TCPSocket方式进行探针检查
            port: 9091 # 检查的端口为9091
          initialDelaySeconds: 15 # 初次延迟时间为15秒
          periodSeconds: 20 # 检查间隔时间为20秒
        volumeMounts: # 定义挂载卷
        - name: logs # 指定挂载卷的名称
          mountPath: /data/logs # 挂载路径为/data/logs
          readOnly: false # 挂载方式为读写
      volumes: # 定义数据卷
      - name: logs # 数据卷名称
        hostPath: # 使用HostPath类型的数据卷
          path: /var/log/feishu # 指定主机上路径为/var/log/feishu
          type: DirectoryOrCreate # 创建目录类型，如果不存在则创建
```



* `编撰人：H211N7`