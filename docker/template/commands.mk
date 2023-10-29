.PHONY: create-service

create-service:
	@echo "Creating service $(name) with image $(image) on port $(port)..."

	@mkdir -p docker/$(name)

	@for file in docker/template/template*; do \
		cp $$file docker/$(name)/`basename $$file | sed "s/template/$(name)/g"`; \
	done

	@upper_name=`echo $(name) | tr '[:lower:]' '[:upper:]'`; \
	find docker/$(name) -type f \( -name "$(name).mk" -or -name "$(name)-docker-compose.yml" -or -name "$(name).phony" \) \
		-exec sed -i "s+<~TMPL_NAME~>+$(name)+g" '{}' \; \
		-exec sed -i "s+<~TMPL_IMAGE~>+$(image)+g" '{}' \; \
		-exec sed -i "s+<~TMPL_DNS~>+$(dns)+g" '{}' \; \
		-exec sed -i "s+<~TMPL_PORT~>+$(port)+g" '{}' \; \
		-exec sed -i "s+<~TMPL_NAME^upper~>+$${upper_name}+g" '{}' \;
