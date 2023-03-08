# Multi-node kubernetes cluster on VirtualBox

This example will help you to run multi-node kubernetes cluster on top of virtual box ubuntu machines.

### Prerequisites
* You need to have Virtual Box installed on your OS
* Installed Vagrant on your OS
* At least 8GB of RAM and 4 CPU cores

### Try it on your own
1. Clone repo locally and in the root directory of the repo run ```vagrant up```\
   Vagrant will set up you 3 machines of ubuntu 20.04 LTS with configuration\
   needed for running multi-node kubernetes cluster
2. SSH to the master node ```vagrant ssh kubemaster```
3. Run the following command inside of your master node to make sure that
   master and agents are running and configured properly ```kubectl get nodes```
4. Run the following command to set up simple Nginx server on kubernetes cluster
    <br>
   ```bash
   kubectl apply -f /k8s_configs/sample.yml
   ```
5. Run the following command to get information about pods where the container is running
   <br>
   ```bash
   kubectl get pods -o wide
   ```
6. Find the infomation on which node pod is running, and then check the ```INTERNAL-IP``` of the node by running the following
   <br>
   ```bash
   kubectl get nodes -o wide
   ```
7. In your browser type ```<node-ip>:30008``` and you should see welcome page of Nginx.
