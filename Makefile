IMAGE_NAME="control_node"

all: build run

build:
	@echo Building
	@docker build --tag ${IMAGE_NAME} .

run:
	@echo Running
	@docker run -it --name ${IMAGE_NAME} ${IMAGE_NAME} bash

clean:
	@echo Cleaning
	@docker stop $(docker ps -aq) || true
	@docker system prune -af

re: clean all
