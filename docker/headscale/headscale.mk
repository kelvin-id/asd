#!make
.PHONY: $(call read_phony_targets,headscale.phony)

HEADSCALE_COMPOSE=docker/headscale/headscale-docker-compose.yml

HEADSCALE_CONFIG=${PWD}/docker/headscale/config.yml
HEADSCALE_WORKSPACE=${PWD}/${SERVICE_DIR}/headscale/config.yml

${HEADSCALE_WORKSPACE}:
	mkdir -p ${PWD}/${SERVICE_DIR}/headscale
	cp ${HEADSCALE_CONFIG} $@
	# wget -O ${HEADSCALE_WORKSPACE} https://raw.githubusercontent.com/juanfont/headscale/main/config-example.yaml
	@printf "📋	Copied headscale config to workspace.\n"

docker-headscale-up: ${HEADSCALE_WORKSPACE}
	@${COMPOSE} -f ${HEADSCALE_COMPOSE} up -d

docker-headscale-down:
	@${COMPOSE} -f ${HEADSCALE_COMPOSE} down

docker-headscale-recreate:
	@${COMPOSE} -f ${HEADSCALE_COMPOSE} up -d --force-recreate

docker-headscale-test:
	@curl -k --resolve headscale.localhost:443:127.0.0.1 https://headscale.localhost
