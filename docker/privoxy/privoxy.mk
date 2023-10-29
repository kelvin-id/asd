#!make
.PHONY: $(call read_phony_targets,privoxy.phony)

PRIVOXY_COMPOSE=docker/privoxy/docker-compose.yml

docker-privoxy-up:
	@${COMPOSE} -f ${PRIVOXY_COMPOSE} up -d

docker-privoxy-down:
	@${COMPOSE} -f ${PRIVOXY_COMPOSE} down

docker-privoxy-recreate:
	@${COMPOSE} -f ${PRIVOXY_COMPOSE} up -d --force-recreate
