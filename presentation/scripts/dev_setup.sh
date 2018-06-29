#!/bin/bash

if which apt > /dev/null; then
  echo "==> Detected Ubuntu"
  echo "----> Installing Kubernetes apt repo"
  apt-get update && apt-get install -y apt-transport-https
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
  sudo apt-get update
  sleep 5
  sudo rm /var/lib/apt/lists/lock
  sudo rm /var/cache/apt/archives/lock
  sleep 5
  echo "----> Installing Docker requirements"
  sudo apt-get install -yq critcl docker.io kubectl 
  sudo echo "source <(kubectl completion bash)" > /etc/profile.d/kube_completion.sh
  sleep 5
else
  echo "YOUR OPERATING SYSTEM IS NOT SUPPORTED"
  echo "MUST BE Ubuntu Xenial"
  exit 1
fi

echo "set docker to use overlay2 storage driver"
systemctl stop docker.service
cat <<EOF > /etc/docker/daemon.json
{
  "storage-driver": "overlay2"
}
EOF
cat /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker.service

echo "installing compose"
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "install compose completion"
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.21.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

echo "download istio-0.5.1 istioctl"
wget https://github.com/istio/istio/releases/download/0.5.1/istio-0.5.1-linux.tar.gz
tar -xvf istio-0.5.1-linux.tar.gz
mv istio-0.5.1/bin .
rm -rf istio-0.5.1 istio-0.5.1-linux.tar.gz
