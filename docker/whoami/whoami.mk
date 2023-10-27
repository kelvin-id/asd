#!make
.PHONY: $(call read_phony_targets,whoami.phony)

WHOAMI_COMPOSE=docker/whoami/docker-compose.yml

docker-whoami-up:
	@${COMPOSE} -f ${WHOAMI_COMPOSE} up -d

docker-whoami-down:
	@${COMPOSE} -f ${WHOAMI_COMPOSE} down

docker-woami-test:
	@curl -k --resolve whoami.example.com:443:127.0.0.1 https://whoami.example.com
