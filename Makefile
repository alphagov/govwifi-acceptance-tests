setup: .frontend .authentication-api .logging-api

build: setup copy-certs
	docker-compose down
	docker-compose build
	docker-compose up -d govwifi-fake-s3
	docker-compose up -d govwifi-db-local
	docker-compose up -d govwifi-admin-db-local
	./scripts/wait_for_mysql
	cat testdatabase/* | docker-compose run --rm govwifi-db-local mysql -uroot -hgovwifi-db-local -ptestpassword govwifi_local
	cat test_admin_database/* | docker-compose run --rm govwifi-admin-db-local mysql -uroot -hgovwifi-admin-db-local -proot govwifi_admin_local
	docker-compose up -d govwifi-authentication-api-local
	docker-compose up -d govwifi-logging-api-local
	docker-compose up -d govwifi-frontend-local
	$(MAKE) clean-certs

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

test: build
	docker-compose up --exit-code-from govwifi-test govwifi-test

destroy:
	docker-compose down

clean: clean-certs
	rm -rf .frontend .logging-api .authentication-api

.PHONY: setup build test destroy clean copy-certs clean-certs
