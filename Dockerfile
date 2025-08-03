FROM python:3.13-slim-bullseye

# Ansible installation
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y python3-pip python3-venv && \
	python3 -m pip install pipx && \
	python3 -m pipx ensurepath && \
	python3 -m pipx install --include-deps ansible && \
	apt-get clean

WORKDIR /home/
COPY ./src .
