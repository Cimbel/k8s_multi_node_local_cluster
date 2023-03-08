#!/bin/bash

mkdir -p /k8s_configs
chmod 777 /k8s_configs

cat <<EOT > /k8s_configs/sample.yml
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx-web
    name: nginx-proxy
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
  selector:
    app: nginx-web
    name: nginx-proxy
EOT

chmod 666 /k8s_configs/sample.yml
