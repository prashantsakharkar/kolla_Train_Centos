#!/bin/bash
yum update -y
yum install ntp -y
systemctl enable ntpd.service
systemctl start ntpd.service
curl -sSL https://get.docker.io | bash
sudo usermod -aG docker root
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo echo 'INSECURE_REGISTRY="--insecure-registry 172.172.3.239:4000"' > /etc/sysconfig/docker      
sudo touch  /etc/systemd/system/docker.service.d/kolla.conf
systemctl daemon-reload
systemctl restart docker
systemctl status docker

mkdir -p /etc/ceph
