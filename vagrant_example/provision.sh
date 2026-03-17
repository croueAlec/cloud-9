#!/bin/bash

sudo	echo "This is a simulated remote node." >> /home/vagrant/README && \
		echo " As per the cloud-1 subject, this node has ubuntu 20.04 LTS, a running SSH daemon and Python installed by default." >> /home/vagrant/README

sudo	mkdir -p /home/vagrant/.ssh/ && \
sudo	cat /vagrant/vagrant_example/ssh_key.pub >> /home/vagrant/.ssh/authorized_keys && \
sudo	chmod 600 /home/vagrant/.ssh/authorized_keys && \
sudo	chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
