setup: .frontend .authentication-api .logging-api

build: setup
	@ # We need to do this, as we get inconsistent results when only refreshing the database.
	docker-compose down

	docker-compose up -d sessions-db user-details-db fake-s3
	docker-compose build
	./scripts/wait_for_mysql sessions-db & ./scripts/wait_for_mysql user-details-db & wait
	cat testdatabase/sessions.sql | docker-compose exec -T sessions-db mysql -uroot -hsessions-db -ptestpassword govwifi_local
	cat testdatabase/user_details.sql | docker-compose exec -T user-details-db mysql -uroot -huser-details-db -ptestpassword govwifi_local
	docker-compose up frontend-raddb-local
	docker-compose up -d frontend-local
	$(MAKE) clean-certs

test: build
	docker-compose run --rm test

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
