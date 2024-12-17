setup: .frontend .authentication-api .logging-api

build: setup
	docker compose down
	docker compose build --progress plain
	docker compose up govwifi-frontend-raddb-local

test: build
	docker compose run --rm govwifi-test

.frontend:
	git clone https://github.com/alphagov/govwifi-frontend.git .frontend

.authentication-api:
	git clone https://github.com/alphagov/govwifi-authentication-api.git .authentication-api

.logging-api:
	git clone https://github.com/alphagov/govwifi-logging-api.git .logging-api

destroy: clean
	docker compose down --volumes

clean:
	rm -rf .frontend .logging-api .authentication-api

.PHONY: setup build test destroy clean
