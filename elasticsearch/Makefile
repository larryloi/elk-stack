#!make
include RELEASE
export $(shell sed 's/=.*//' RELEASE)
#IMAGE := docker-repos:8123/i2/cnfas:0.2.37
#IMAGE := cnfas:0.2.3
#CONTAINER := cnfas
APP_SRC_PATH := $(realpath ../)
#WORKDIR := /app
BASE_IMAGE := ruby-freetds:2.5.8
ENV_FILE := bundler.env
SSHKEY_PATH := /root/.ssh

bundle-check:
	docker run --rm -it --env-file $(ENV_FILE) -v $(APP_SRC_PATH):$(WORKDIR) -v $(SSHKEY_PATH):$(SSHKEY_PATH) -w $(WORKDIR) $(BASE_IMAGE) bundle check
bundle-update:
	docker run --rm -it --env-file $(ENV_FILE) -v $(APP_SRC_PATH):$(WORKDIR) -v $(SSHKEY_PATH):$(SSHKEY_PATH) -w $(WORKDIR) $(BASE_IMAGE) bundle update
bundle-install:
	docker run --rm -it --env-file $(ENV_FILE) -v $(APP_SRC_PATH):$(WORKDIR) -v $(SSHKEY_PATH):$(SSHKEY_PATH) -w $(WORKDIR) $(BASE_IMAGE) bundle install
bundle-show:
	docker run --rm -it --env-file $(ENV_FILE) -v $(APP_SRC_PATH):$(WORKDIR) -v $(SSHKEY_PATH):$(SSHKEY_PATH) -w $(WORKDIR) $(BASE_IMAGE) bundle show $(GEM)
bundle-bash:
	docker run --rm -it --env-file $(ENV_FILE) -v $(APP_SRC_PATH):$(WORKDIR) -v $(SSHKEY_PATH):$(SSHKEY_PATH) -w $(WORKDIR) $(BASE_IMAGE) /bin/bash

build:
	docker build --build-arg ELK_VERSION=${TAG} -f Dockerfile . -t ${REPO_PATH}$(IMAGE):$(TAG)

push:
	docker push ${REPO_PATH}${IMAGE}:${TAG}

image.rm:
	docker rmi $$(docker images|grep ${REPO_PATH}${IMAGE} | grep ${TAG} |head -1 |awk '{print $$3}')

create:
	docker create --name $(IMAGE) ${REPO_PATH}$(IMAGE):$(TAG) /bin/bash

bash:
	docker run --rm -it ${REPO_PATH}${IMAGE}:${TAG} /bin/bash
run:
	docker run --rm -it ${REPO_PATH}${IMAGE}:${TAG}
attach:
	docker exec -it $$(docker ps | grep $(IMAGE) | head -1 | awk '{print $$1}') /bin/bash
logs:
	docker logs -f $$(docker ps | grep $(IMAGE) | head -1 | awk '{print $$1}')
execute:
	docker run --rm -it $(IMAGE) bash -c '$(COMMAND)'

# export:
#       docker export $(CONTAINER) > $(CONTAINER).tar
# import:
#       cat $(CONTAINER).tar | docker import - $(CONTAINER) && rm $(CONTAINER).tar
#
# flatten:
#       make create && make export && make import

remove_all_containers:
	docker rm $$(docker ps -aq)
remove_all_images:
	docker rmi $$(docker images -aq)
remove_exited_containers:
	docker rm -v $$(docker ps -q -f status=exited)
remove_dangling_images:
	docker rmi $$(docker images -q -f dangling=true)
