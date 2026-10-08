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
VAGRANT_FILE_PATH="./vagrant_example/Vagrantfile"

################################################################################
#                                     RULES                                    #
################################################################################

all: build run

test: vup test_build test_run

build: init_ssh_key
	@printf "$(CYAN)- Building$(DEFAULT) Docker Control Node\n"
	@docker build --tag ${IMAGE_NAME} .

run:
	@printf "$(GREEN)* Running $(BWHITE)Docker Control Node$(DEFAULT)\n"
	@docker run -e ANSIBLE_TARGET_IP=${VM_IP} -it -e AUTO_START="${AUTO_START}" --name ${IMAGE_NAME} ${IMAGE_NAME} bash

clean:
	@printf "$(RED)! Cleaning$(DEFAULT)\n"
	@docker stop $(docker ps -aq) || true
	@docker system prune -af

init_ssh_key:
	@if [ ! -f "./vagrant_example/ssh_key" ]; then \
		printf "$(CYAN)> Copying$(DEFAULT) vagrant VM $(BWHITE)ssh_key$(DEFAULT)\n"; \
		cp ${VAGRANT_DOTFILE_PATH}/machines/default/virtualbox/private_key vagrant_example/ssh_key; \
	fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Test Rules ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

vup:
	@printf "$(CYAN)- Compiling$(DEFAULT) vagrant VM\n"
	@VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant up
	

vdes:
	@printf "$(RED)! Destroying$(DEFAULT) Vagrant VMs\n"
	@VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant destroy -f
	@rm -rf ${VAGRANT_DOTFILE_PATH} vagrant_example/ssh_key

vssh:
	@printf "$(GREEN)* Running $(BWHITE)Vagrant SSH$(DEFAULT)\n"
	@VAGRANT_VAGRANTFILE=${VAGRANT_FILE_PATH} vagrant ssh

re: clean all
