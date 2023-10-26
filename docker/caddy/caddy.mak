#!make

CADDY_COMPOSE=docker/caddy/docker-compose.yml

docker-caddy-network:
	@docker network create caddy

docker-caddy-up:
	@${COMPOSE} -f ${CADDY_COMPOSE} up -d

docker-caddy-down:
	@${COMPOSE} -f ${CADDY_COMPOSE} down

# Sources
# https://caddyserver.com/docs/automatic-https
# https://github.com/lucaslorentz/caddy-docker-proxy#basic-usage-example-using-docker-compose
