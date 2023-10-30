#!make
.PHONY: $(call read_phony_targets,coredns.phony)

COREDNS_CONTAINER=asd-coredns
COREDNS_COMPOSE=docker/coredns/coredns-docker-compose.yml
COREDNS_CONFIG=${PWD}/docker/coredns/Corefile
COREDNS_WORKSPACE=${PWD}/${SERVICE_DIR}/coredns/Corefile

COREDNS_DIR=workspace/service/coredns
${COREDNS_DIR}:
	mkdir -p ${COREDNS_DIR}

${COREDNS_WORKSPACE}: ${COREDNS_DIR}
	cp ${COREDNS_CONFIG} $@
	@printf "📋	Copied coredns Corefile to workspace.\n"

docker-coredns-up: ${COREDNS_WORKSPACE}
	@${COMPOSE} -f ${COREDNS_COMPOSE} up -d

docker-coredns-down:
	@${COMPOSE} -f ${COREDNS_COMPOSE} down

docker-coredns-recreate:
	@${COMPOSE} -f ${COREDNS_COMPOSE} up -d --force-recreate

docker-coredns-logs:
	@${COMPOSE} -f ${COREDNS_COMPOSE} logs --follow

docker-coredns-test:
	docker exec -it ${COREDNS_CONTAINER} nslookup google.com

docker-coredns-connect:
	docker exec -it ${COREDNS_CONTAINER} /bin/sh
