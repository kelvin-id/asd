#!make
.PHONY: $(call read_phony_targets,caddy.phony)

# Set the name of the Caddy container
CADDY_CONTAINER=asd-caddy

# Set the path where the Caddy root certificate will be saved on the host machine
CADDY_CERT_PATH=${PWD}/root.crt

CADDY_COMPOSE=docker/caddy/docker-compose.yml

CADDY_DIR=workspace/service/caddy
${CADDY_DIR}:
	mkdir -p ${CADDY_DIR}

docker-caddy-up: ${CADDY_DIR}
	@${COMPOSE} -f ${CADDY_COMPOSE} up -d

docker-caddy-down:
	@${COMPOSE} -f ${CADDY_COMPOSE} down

docker-caddy-recreate:
	@${COMPOSE} -f ${CADDY_COMPOSE} up -d --force-recreate

docker-caddy-connect:
	docker exec -it ${CADDY_CONTAINER} /bin/sh

# Copy the Caddy root certificate
caddy-copy-ca:
	sudo cp ${PWD}/${CADDY_DIR}/pki/authorities/local/root.crt .
	sudo cp ${PWD}/${CADDY_DIR}/pki/authorities/local/intermediate.crt .
	sudo chown ${USER}:${USER} root.crt intermediate.crt

# Install the Caddy root certificate in the system's trust store
# C:\Windows\system32\drivers\etc
# /etc/hosts
caddy-install-ca:
	certutil -addstore -f "Root" ${CADDY_CERT_PATH}
