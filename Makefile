include .env
export

export PROJECT_ROOT=$(shell pwd )
env-up:
	@docker compose up -d todoapp-postgres

env-down:
	@docker compose down todoapp-postgres

env-cleanup:
	@read -p "Do you really want clean envFiles? [y/N]:" ans; \
	if [ "$$ans" = "y" ]; then \
	  docker compose down todoapp-postgres && \
	  rm -rf out && \
      echo "You clean envFiles";\
	else \
	  echo "Decline cleaning envFiles"; \
	fi

migrate-create:
	@if [ -z "$(seq)" ] ; then \
  		echo "The parameter missing. For example make migrate-create seq=init"; \
  		exit 1; \
  		fi; \
	docker compose run --rm todoapp-postgres-migrate \
		create \
		-ext sql \
		-dir /migrations \
		-seq "$(seq)"

migrate-up:
	@make migrate-action action=up


migrate-down:
	@make migrate-action action=down

migrate-action:
	@if [ -z "$(action)" ] ; then \
      		echo "The [action] parameter missing. For example make migrate-action action=up"; \
      		exit 1; \
      		fi; \
	docker compose run --rm todoapp-postgres-migrate \
    		-path /migrations \
    		-database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@todoapp-postgres:5432/${POSTGRES_DB}?sslmode=disable \
    		"$(action)"

env-port-forward:
	@docker compose up -d port-forwarder

env-port-close:
	@docker compose stop port-forwarder

