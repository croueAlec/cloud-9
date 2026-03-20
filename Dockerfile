FROM python:3.8.20-slim-bullseye

# Basic installation
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y less ssh vim && \
	echo "alias c=clear" >> /root/.bashrc && \
	echo "alias aplp='ansible-playbook playbook.yml --ask-vault-pass'" >> /root/.bashrc

# Ansible installation
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y python3-pip python3-venv && \
	python3 -m pip install pipx && \
	python3 -m pipx ensurepath && \
	python3 -m pipx install --include-deps ansible && \
	pip3 install argcomplete && \
	activate-global-python-argcomplete && \
	apt-get clean

# Setup SSH connection
ARG	ANSIBLE_TARGET_IP
ENV	ANSIBLE_TARGET_IP=${ANSIBLE_TARGET_IP}
RUN	mkdir -p /root/.ssh/ && chmod 700 /root/.ssh
COPY .vagrant/machines/default/virtualbox/private_key /root/.ssh/ssh_key
RUN	chmod 600 /root/.ssh/ssh_key

WORKDIR /home/
COPY ./src .
RUN chmod 600 secrets.yml
