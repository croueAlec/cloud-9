################################################################################
#                                    COLORS                                    #
################################################################################
DEFAULT    = \033[0m
BLACK    = \033[0;30m
RED        = \033[0;31m
GREEN    = \033[0;32m
YELLOW    = \033[0;33m
BLUE    = \033[0;34m
PURPLE    = \033[0;35m
CYAN    = \033[0;36m
BWHITE    = \033[1;37m


################################################################################
#                                   VARIABLES                                  #
################################################################################

IMAGE_NAME="control_node"
AUTO_START="false"

export VM_IP=192.168.60.60
export VAGRANT_HOME=/tmp/.vagrant.d
VAGRANT_FILE_PATH="./vagrant_example/Vagrantfile"

################################################################################
#                                     RULES                                    #
################################################################################

all: build run

test: vup test_build test_run

build: init_ssh_key
	@echo "$(CYAN)- Building$(DEFAULT) Docker Control Node"
	@docker build --build-arg ANSIBLE_TARGET_IP="${VM_IP}" --tag ${IMAGE_NAME} .

run:
	@echo "$(GREEN)* Running $(BWHITE)$@$(DEFAULT) Docker Control Node"
	@docker run -it -e AUTO_START="${AUTO_START}" --name ${IMAGE_NAME} ${IMAGE_NAME} bash

clean:
	@echo "$(RED)! Cleaning$(DEFAULT)"
	@docker stop $(docker ps -aq) || true
	@docker system prune -af

init_ssh_key:
	if [ ! -f "./vagrant_example/ssh_key" ]; then \
		echo Creating missing ssh_key; \
		ssh-keygen -f ./vagrant_example/ssh_key -t rsa -N ""; \
	fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Test Rules ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

vup: init_ssh_key
	@echo "$(CYAN)- Compiling$(DEFAULT) vagrant VM"
	VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant up

vdes:
	@echo "$(RED)! Destroying$(DEFAULT) Vagrant VMs"
	@rm -rf ./vagrant ${VAGRANT_HOME}
	@VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant destroy -f

vssh:
	@echo "$(GREEN)* Running $(BWHITE)$@$(DEFAULT) Vagrant SSH"
	@VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant ssh

re: clean all
