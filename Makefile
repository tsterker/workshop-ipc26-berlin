#!/usr/bin/make -f

.PHONY: help up down test

help: ## Show this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | column -t -s ':' | sed 's/^  //'

up: ## Start all kata containers in background.
	(cd tdd/rock-paper-scissors && docker-compose up -d)
	(cd tdd/guess-random-number && docker-compose up -d)
	(cd refactoring/parrot && docker-compose up -d)
	(cd refactoring/tennis && docker-compose up -d)

down: ## Stop and remove all kata containers.
	docker rm -f ipc26-rps ipc26-guess-number ipc26-parrot ipc26-tennis 2>/dev/null || true

test: ## Run tests in all kata containers (requires 'make up' first).
	docker exec ipc26-rps composer test
	docker exec ipc26-guess-number composer test
	docker exec ipc26-parrot composer test
	docker exec ipc26-tennis composer test
