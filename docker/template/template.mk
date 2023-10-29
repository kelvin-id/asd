#!make
.PHONY: $(call read_phony_targets,<~TMPL_NAME~>.phony)

<~TMPL_NAME^upper~>_COMPOSE=docker/<~TMPL_NAME~>/<~TMPL_NAME~>-docker-compose.yml

docker-<~TMPL_NAME~>-up:
	@${COMPOSE} -f ${<~TMPL_NAME^upper~>_COMPOSE} up -d

docker-<~TMPL_NAME~>-down:
	@${COMPOSE} -f ${<~TMPL_NAME^upper~>_COMPOSE} down

docker-<~TMPL_NAME~>-test:
	@curl -k --resolve <~TMPL_NAME~>.asd:443:127.0.0.1 https://<~TMPL_NAME~>.asd
