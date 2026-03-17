FROM python:3.13-slim-bullseye

# Basic installation
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y less && \
	echo "alias c=clear" >> /root/.bashrc

# Ansible installation
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y python3-pip python3-venv && \
	python3 -m pip install pipx && \
	python3 -m pipx ensurepath && \
	python3 -m pipx install --include-deps ansible && \
	pip3 install argcomplete && \
	activate-global-python-argcomplete && \
	apt-get clean

WORKDIR /home/
COPY ./src .
