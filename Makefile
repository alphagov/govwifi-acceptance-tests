setup: .frontend .authentication-api .logging-api

build: setup copy-certs
	docker-compose build
	@# This will create containers, and swap them in if they're already running.
	docker-compose up --no-start govwifi-frontend-local
	$(MAKE) clean-certs

test: build ensure_db
	docker-compose run --rm govwifi-test

ensure_db:
	docker-compose up -d govwifi-db-local govwifi-db-2-local
	./scripts/wait_for_mysql govwifi-db-local & ./scripts/wait_for_mysql govwifi-db-2-local & wait

stop:
	docker-compose stop

copy-certs:
	cp -r "test-certs" "acceptance_tests/.certs"
	cp -r "test-certs" "fake-s3/.certs"

clean-certs:
	rm -rf "acceptance_tests/.certs"
	rm -rf "fake-s3/.certs"

.frontend:
	git clone https://github.com/alphagov/govwifi-frontend.git .frontend

.authentication-api:
	git clone https://github.com/alphagov/govwifi-authentication-api.git .authentication-api

.logging-api:
	git clone https://github.com/alphagov/govwifi-logging-api.git .logging-api

destroy: .frontend .authentication-api .logging-api
	docker-compose down

clean: clean-certs
	rm -rf .frontend .logging-api .authentication-api

.PHONY: setup build test destroy clean copy-certs clean-certs
