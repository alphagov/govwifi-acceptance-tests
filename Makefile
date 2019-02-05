setup: .frontend .authentication-api .logging-api

build: setup copy-certs
	@ # We need to do this, as we get inconsistent results when only refreshing the database.
	docker-compose down

	docker-compose up -d govwifi-db-local
	docker-compose build
	./scripts/wait_for_mysql
	cat testdatabase/* | docker-compose run --rm govwifi-db-local mysql -uroot -hgovwifi-db-local -ptestpassword govwifi_local
	docker-compose up -d govwifi-frontend-local
	$(MAKE) clean-certs

test: build
	docker-compose run --rm govwifi-test

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
