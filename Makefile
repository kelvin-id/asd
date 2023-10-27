#!make
.SILENT:
include scripts/make/modules/common/functions.mk

# > Config

LOCAL_DIR?=local
WORKSPACE_DIR?=workspace
CONFIG_FILE?=.env
CONFIG_PATH?=./${WORKSPACE_DIR}/config/${CONFIG_FILE}

# > Setup

#	execute when calling `make`
all: ${WORKSPACE_DIR} ${CONFIG_PATH}
	@printf '🚀	Run the start command to launch your environment.\n'

#	Executes only if .env does not exist or the origin has
${CONFIG_PATH}: ./config/.env-example
	cp $< $@
	@printf "📋	Copied default config to workspace.\n"

#	Import and expose all VARS from the config to all make targets 
-include ${CONFIG_PATH}
export $(shell sed 's/=.*//' ${CONFIG_PATH})

# > Modules

-include scripts/make/modules/browser/browser.mk
-include scripts/make/modules/container/docker.mk

# > Services

# 	caddy - webserver
include docker/caddy/caddy.mk
# 	privoxy - proxyserver
include docker/privoxy/privoxy.mk
# 	whoami - test
include docker/whoami/whoami.mk
# 	terminal
include docker/terminal/terminal.mk
#	codeserver
include docker/codeserver/codeserver.mk

# > Project

${LOCAL_DIR}:
	mkdir -p local

${WORKSPACE_DIR}:
	mkdir -p ${WORKSPACE_DIR}/config
	@printf "📁	Created directory structure workspace/config.\n"

# SERVICES?=caddy whoami privoxy terminal 
SERVICES?=codeserver

# Define a function to generate targets
define g_docker_targets
$(foreach service,$(SERVICES),docker-$(service)-$(1))
endef

SERVICES_PULL=$(call g_docker_targets,pull)
SERVICES_UP=$(call g_docker_targets,up)
SERVICES_DOWN=$(call g_docker_targets,down)
SERVICES_RECREATE=$(call g_docker_targets,recreate)

pull:
	@make -j ${SERVICES_PULL}

start: ${LOCAL_DIR} ${WORKSPACE_DIR}
	@make -j ${SERVICES_UP}
	@wait
	@docker ps

stop:
	@make -j ${SERVICES_DOWN}
	@docker ps

renew:
	@make -j ${SERVICES_RECREATE}
	@docker ps

browse:
	${BROWSER}

.PHONY: pull start stop renew browse
