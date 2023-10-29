#!make
.PHONY: $(call read_phony_targets,coredns.phony)

COREDNS_CONTAINER=asd-coredns
COREDNS_COMPOSE=docker/coredns/coredns-docker-compose.yml

docker-coredns-up:
	@${COMPOSE} -f ${COREDNS_COMPOSE} up -d

docker-coredns-down:
	@${COMPOSE} -f ${COREDNS_COMPOSE} down

docker-coredns-recreate:
	@${COMPOSE} -f ${COREDNS_COMPOSE} up -d --force-recreate

docker-coredns-test:
	docker exec -it ${COREDNS_CONTAINER} nslookup google.com

docker-coredns-connect:
	docker exec -it ${CADDY_CONTAINER} /bin/sh
