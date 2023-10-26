#!make

PRIVOXY_COMPOSE=docker/privoxy/docker-compose.yml

docker-privoxy-up:
	@${COMPOSE} -f ${PRIVOXY_COMPOSE} up -d

docker-privoxy-down:
	@${COMPOSE} -f ${PRIVOXY_COMPOSE} down
