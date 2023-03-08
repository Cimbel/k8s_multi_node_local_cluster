# 1
# Open "/node_connection_info" file to check 
# command to connect worker nodes to master node

# 2
# label for node1
kubectl label node kubenode01 node-role.kubernetes.io/worker1=worker1
kubectl label node kubenode01 node-role.kubernetes.io/worker=worker

# 3
# label for node2
kubectl label node kubenode02 node-role.kubernetes.io/worker2=worker2
kubectl label node kubenode01 node-role.kubernetes.io/worker=worker
