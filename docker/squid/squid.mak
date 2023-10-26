#!make

SQUID_COMPOSE=docker/squid/docker-compose.yml

docker-squid-up:
	@${COMPOSE} -f ${SQUID_COMPOSE} up -d

docker-squid-down:
	@${COMPOSE} -f ${SQUID_COMPOSE} down
