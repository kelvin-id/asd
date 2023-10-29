#!make
.PHONY: $(call read_phony_targets,codeserver.phony)

MACHINE_OS=alpine
OS_VERSION=
MACHINE_ARCH=<QEMU?>
DEVELOPMENT_LANG=python

CODESERVER_IMAGE=codeserver-asd-terminal
CODESERVER_PATH=${PWD}/alpine.python.dockerfile
CODESERVER_COMPOSE=docker/codeserver/${MACHINE_OS}.${DEVELOPMENT_LANG}.docker-compose.yml

# Target to check if Dockerfile has changed and trigger a rebuild if necessary
docker-codeserver-check:
	@${COMPOSE} -f ${CODESERVER_COMPOSE} build

docker-codeserver-up: docker-codeserver-check
	@${COMPOSE} -f ${CODESERVER_COMPOSE} up -d

docker-codeserver-down:
	@${COMPOSE} -f ${CODESERVER_COMPOSE} down

docker-codeserver-recreate:
	@${COMPOSE} -f ${CODESERVER_COMPOSE} up -d --force-recreate
