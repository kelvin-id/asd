
#!make

# > Config

# > Modules

-include scipts/make/modules/browser/browser.mak
-include scipts/make/modules/container/docker.mak

# > Services

# caddy - webserver
-include docker/caddy/caddy.mak
# squid - proxyserver
-include docker/squid/squid.mak
# whoami - test
-include docker/whoami/whoami.mak

# > Project

start: docker-caddy-up docker-whoami-up docker-squid-up
	docker ps
stop: docker-caddy-down docker-whoami-down docker-squid-down
	docker ps

# up:
# 	@${COMPOSE} up -d

# setup: docker-network
# 	@echo "Setting up environment..."
# 	@make up

# 	@echo "Configuring proxy for browser..."
# 	@start-with-proxy

# down:
# 	@${COMPOSE} down

# teardown:
# 	@echo "Tearing down environment..."
# 	@make down

browse:
	${BROWSER}

.PHONY: setup teardown
