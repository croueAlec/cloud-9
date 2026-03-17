#!/bin/bash

echo "This is a simulated remote node." >> /home/vagrant/README && \
echo " As per the cloud-1 subject, this node has ubuntu 20.04 LTS, a running SSH daemon and Python installed by default." >> /home/vagrant/README

sudo	mkdir -p /home/vagrant/.ssh/ && \
sudo	cat /vagrant/vagrant_example/ssh_key.pub >> /home/vagrant/.ssh/authorized_keys && \
sudo	chmod 600 /home/vagrant/.ssh/authorized_keys && \
sudo	chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys

echo "This is a simulated remote node." >> /home/deploy/README && \
echo " As per the cloud-1 subject, this node has ubuntu 20.04 LTS, a running SSH daemon and Python installed by default." >> /home/deploy/README

useradd	-m -s /bin/bash deploy
echo	"deploy:deploy" | chpasswd
echo	"deploy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

mkdir -p /home/deploy/.ssh && \
cat /vagrant/vagrant_example/ssh_key.pub >> /home/deploy/.ssh/authorized_keys && \
chmod 700 /home/deploy/.ssh/ && \
chmod 600 /home/deploy/.ssh/authorized_keys && \
chown deploy:deploy /home/deploy/.ssh/
