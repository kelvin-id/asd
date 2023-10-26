
#!make
.SILENT:

# > Config

# > Modules

-include scipts/make/modules/browser/browser.mak
-include scipts/make/modules/container/docker.mak

# > Services

# caddy - webserver
-include docker/caddy/caddy.mak
# privoxy - proxyserver
-include docker/privoxy/privoxy.mak
# whoami - test
-include docker/whoami/whoami.mak

# > Project

dir-local:
	mkdir -p local

start: dir-local
	@make -j docker-caddy-up docker-whoami-up docker-privoxy-up
	@docker ps

stop:
	@make -j docker-caddy-down docker-whoami-down docker-privoxy-down
	@docker ps

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
