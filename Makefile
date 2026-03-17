IMAGE_NAME="control_node"
AUTO_START="false"

export VM_IP=192.168.60.60
export VAGRANT_HOME=/home/acroue/goinfre/.vagrant.d
VAGRANT_FILE_PATH="./vagrant_example/Vagrantfile"

all: build run

test: vup test_build test_run

build:
	@echo Building
	@docker build --tag ${IMAGE_NAME} .

run:
	@echo Running
	@docker run -it -e AUTO_START="${AUTO_START}" ANSIBLE_TARGET_IP="${VM_IP}" --name ${IMAGE_NAME} ${IMAGE_NAME} bash

clean:
	@echo Cleaning
	@docker stop $(docker ps -aq) || true
	@docker system prune -af

vup:
	@echo Building and starting the vagrant VM
	VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant up

vdes:
	@echo Destroying the vagrant VM
	VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant destroy -f

vssh:
	@echo SSH access into the vagrant VM
	VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant ssh

re: clean all
