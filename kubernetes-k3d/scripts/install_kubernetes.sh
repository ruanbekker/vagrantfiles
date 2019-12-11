#!/bin/bash
set -e

which docker
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | sudo bash
k3d create --name "k3d-cluster" --image "docker.io/rancher/k3s:v0.9.0" --publish "8087:8080" --workers 1
sleep 10
mkdir -p /home/vagrant/.config/k3d/k3d-cluster
sudo chown -R vagrant:vagrant /home/vagrant
echo 'export KUBECONFIG="$(k3d get-kubeconfig --name='k3d-cluster')"' > /tmp/.kubernetes.sh
echo '. /tmp/.kubernetes.sh' >> /home/vagrant/.bashrc
source /tmp/.kubernetes.sh

sleep 10
kubectl get nodes
kubectl version
