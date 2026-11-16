FROM python:3.14.8-slim-bookworm AS base

# Basic installation
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y less ssh vim && \
	echo "alias c=clear" >> /root/.bashrc && \
	echo "alias aplp='ansible-playbook playbook.yml --ask-vault-pass'" >> /root/.bashrc

ENV PATH="/root/.local/bin:$PATH"

# Ansible installation
# RUN	apt-get update && apt-get upgrade -y && \
# 	apt-get install -y python3-pip python3-venv boto3 botocore && \
# 	python3 -m pip install pipx && \
# 	python3 -m pipx ensurepath && \
# 	python3 -m pipx install --include-deps ansible && \
# 	pip3 install argcomplete && \
# 	activate-global-python-argcomplete && \
# 	ansible-galaxy collection install amazon.aws && \
# 	apt-get clean

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y python3-pip python3-venv && \
	python3 -m pip install --break-system-packages pipx argcomplete && \
	pipx install --include-deps ansible && \
	pipx inject ansible boto3 botocore && \
	activate-global-python-argcomplete && \
	ansible-galaxy collection install amazon.aws && \
	apt-get clean

WORKDIR /home/
COPY ./src .
RUN chmod 600 secrets.yml


# Setup vagrant SSH connection
FROM base AS vagrant_test

ENV	ANSIBLE_TARGET_IP=""
ENV CONTROL_NODE_STATUS="vagrant"
RUN	mkdir -p /root/.ssh/ && chmod 700 /root/.ssh
COPY vagrant_example/ssh_key /root/.ssh/ssh_key
RUN	chmod 600 /root/.ssh/ssh_key


# Setup AWS connection
FROM base AS aws

ENV CONTROL_NODE_STATUS="aws"
RUN mkdir -p ~/.aws/ /root/.ssh && chmod 700 /root/.ssh
COPY .aws_credentials ~/.aws/credentials
COPY --chmod=0600 cloud-1.pem /root/.ssh/ssh_key
