setup: .frontend .authentication-api .logging-api

build: setup
	@ # We need to do this, as we get inconsistent results when only refreshing the database.
	docker-compose down

	docker-compose up -d govwifi-sessions-db govwifi-user-details-db govwifi-fake-s3
	docker-compose build
	./scripts/wait_for_mysql govwifi-sessions-db & ./scripts/wait_for_mysql govwifi-user-details-db & wait
	cat testdatabase/sessions.sql | docker-compose exec -T govwifi-sessions-db mysql -uroot -hgovwifi-sessions-db -ptestpassword govwifi_local
	cat testdatabase/user_details.sql | docker-compose exec -T govwifi-user-details-db mysql -uroot -hgovwifi-user-details-db -ptestpassword govwifi_local
	docker-compose up govwifi-frontend-raddb-local
	docker-compose up -d govwifi-frontend-local
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
