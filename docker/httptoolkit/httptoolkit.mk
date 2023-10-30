#!make
.PHONY: $(call read_phony_targets,httptoolkit.phony)

HTTPTOOLKIT_DIR=workspace/service/httptoolkit
${HTTPTOOLKIT_DIR}:
	mkdir -p ${HTTPTOOLKIT_DIR}

HTTPTOOLKIT_CONTAINER=asd-httptoolkit
HTTPTOOLKIT_COMPOSE=docker/httptoolkit/httptoolkit-docker-compose.yml

docker-httptoolkit-up: ${HTTPTOOLKIT_DIR}
	@${COMPOSE} -f ${HTTPTOOLKIT_COMPOSE} up -d

docker-httptoolkit-down:
	@${COMPOSE} -f ${HTTPTOOLKIT_COMPOSE} down

docker-httptoolkit-build:
	@${COMPOSE} -f ${HTTPTOOLKIT_COMPOSE} build

docker-httptoolkit-build-no-cache:
	@${COMPOSE} -f ${HTTPTOOLKIT_COMPOSE} build --no-cache

docker-httptoolkit-recreate:
	@${COMPOSE} -f ${HTTPTOOLKIT_COMPOSE} up -d --force-recreate

docker-httptoolkit-test:
	@curl -k --resolve httptoolkit.${TLD}:443:127.0.0.1 https://httptoolkit.${TLD}

docker-httptoolkit-logs:
	@${COMPOSE} -f ${HTTPTOOLKIT_COMPOSE} logs --follow

docker-httptoolkit-connect:
	docker exec -it ${HTTPTOOLKIT_CONTAINER} /bin/sh
