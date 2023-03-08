#!/bin/bash

sudo -i

weave_version="v2.8.1"
non_root_user="vagrant"
non_root_group="vagrant"
non_root_user_dir=/home/$non_root_user
master_node_ip=$(ifconfig enp0s8 | grep inet | head -n 1 | awk '{print $2}')

kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address=$master_node_ip --cri-socket unix:///var/run/cri-dockerd.sock > /node_connection_info
export KUBECONFIG=/etc/kubernetes/admin.conf

sleep 5

mkdir -p $non_root_user_dir/.kube
cp -i /etc/kubernetes/admin.conf $non_root_user_dir/.kube/config
chmod -R 775 $non_root_user_dir/.kube
chown $non_root_user:$non_root_group $non_root_user_dir/.kube/config

kubectl apply -f https://github.com/weaveworks/weave/releases/download/${weave_version}/weave-daemonset-k8s.yaml
apt-get update && apt-get -y install sshpass
connect_node=$(cat /node_connection_info | tail -n 2)
sshpass -p vagrant ssh -oStrictHostKeyChecking=no vagrant@192.168.56.3 "sudo $connect_node --cri-socket unix:///var/run/cri-dockerd.sock"
sshpass -p vagrant ssh -oStrictHostKeyChecking=no vagrant@192.168.56.4 "sudo $connect_node --cri-socket unix:///var/run/cri-dockerd.sock"

sleep 15

# label for node1
kubectl label node kubenode01 node-role.kubernetes.io/worker1=worker1
kubectl label node kubenode01 node-role.kubernetes.io/worker=worker

# label for node2
kubectl label node kubenode02 node-role.kubernetes.io/worker2=worker2
kubectl label node kubenode01 node-role.kubernetes.io/worker=worker

# label for master
kubectl label node kubemaster node-role.kubernetes.io/master=master
