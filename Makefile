setup: .frontend .authentication-api .logging-api

build: setup
	docker-compose down
	docker-compose build
	docker-compose up govwifi-frontend-raddb-local
	$(MAKE) clean-certs

test: build
	docker-compose run --rm govwifi-test

.frontend:
	git clone https://github.com/alphagov/govwifi-frontend.git .frontend

.authentication-api:
	git clone https://github.com/alphagov/govwifi-authentication-api.git .authentication-api

.logging-api:
	git clone https://github.com/alphagov/govwifi-logging-api.git .logging-api

destroy: .frontend .authentication-api .logging-api
	docker-compose down --volumes

clean: clean-certs
	rm -rf .frontend .logging-api .authentication-api

.PHONY: setup build test destroy clean clean-certs
