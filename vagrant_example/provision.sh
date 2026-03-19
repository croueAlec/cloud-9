#!/bin/bash

echo "This is a simulated remote node." >> /home/vagrant/README && \
echo " As per the cloud-1 subject, this node has ubuntu 20.04 LTS, a running SSH daemon and Python installed by default." >> /home/vagrant/README

sudo	mkdir -p /home/vagrant/.ssh/ # && \
# sudo	cat /vagrant/vagrant_example/ssh_key.pub >> /home/vagrant/.ssh/authorized_keys && \
# sudo	chmod 600 /home/vagrant/.ssh/authorized_keys && \
# sudo	chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys


# useradd	-m -s /bin/bash deploy
# echo	"deploy:deploy" | chpasswd
# echo	"deploy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# echo "This is a simulated remote node." >> /home/deploy/README && \
# echo " As per the cloud-1 subject, this node has ubuntu 20.04 LTS, a running SSH daemon and Python installed by default." >> /home/deploy/README

# mkdir -p /home/deploy/.ssh && \
# cat /vagrant/vagrant_example/ssh_key.pub >> /home/deploy/.ssh/authorized_keys && \
# chmod 700 /home/deploy/.ssh/ && \
# chmod 600 /home/deploy/.ssh/authorized_keys && \
# chown -R deploy:deploy /home/deploy/

sudo apt-get update && \
sudo apt-get install -y software-properties-common && \
sudo add-apt-repository ppa:deadsnakes/ppa && \
sudo apt-get install -y python3.9 && \
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2 && \
sudo update-alternatives --config python3
