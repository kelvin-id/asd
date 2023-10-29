#!make
.PHONY: $(call read_phony_targets,terminal.phony)

MACHINE_OS=alpine
OS_VERSION=
MACHINE_ARCH=<QEMU?>
DEVELOPMENT_LANG=python

TERMINAL_IMAGE=asd-terminal
TERMINAL_PATH=${PWD}/alpine.python.dockerfile
TERMINAL_COMPOSE=docker/terminal/${MACHINE_OS}.${DEVELOPMENT_LANG}.docker-compose.yml

# Target to check if Dockerfile has changed and trigger a rebuild if necessary
docker-terminal-check:
	@${COMPOSE} -f ${TERMINAL_COMPOSE} build

docker-terminal-up: docker-terminal-check
	@${COMPOSE} -f ${TERMINAL_COMPOSE} up -d

docker-terminal-down:
	@${COMPOSE} -f ${TERMINAL_COMPOSE} down

docker-terminal-recreate:
	@${COMPOSE} -f ${TERMINAL_COMPOSE} up -d --force-recreate
