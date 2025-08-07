# Config
PROJECT_NAME	?= $(shell basename $(CURDIR))
SERVICES		= $(shell docker compose $(DC_FILE) config --services 2>/dev/null || echo "")
DC_FILE			= ./srcs/docker-compose.yml
DC				= @docker compose -f $(DC_FILE)

# Colors
GREEN			= \033[0;32m
YELLOW			= \033[1;33m
RED				= \033[0;31m
BLUE			= \033[0;34m
NC				= \033[0m

.PHONY: help up down restart build logs shell clean fclean status

help: ## Display all commands
	@echo "$(GREEN)$(PROJECT_NAME)$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

up: ## Start services
	@echo "$(GREEN)Démarrage des services...$(NC)"
	@mkdir -p ~/data/mariadb ~/data/wordpress
	$(DC) up -d
#@make status

down: ## Stop services
	@echo "$(YELLOW)Arrêt des services...$(NC)"
	$(DC) down

restart: ## Restart services
ifdef SERVICE
	$(DC) restart $(SERVICE)
else
	$(DC) restart
endif

build: ## Build all images from docker-compose.yml - do this first.
	@echo "$(GREEN)Building images...$(NC)"
	$(DC) build

rebuild: down build up ## Stops, re-build and restart services

status: ## Display status
	@echo "$(BLUE)Statut:$(NC)"
	$(DC) ps

logs: ## Display logs of all services or write 'SERVICE=<service>' to see a specify log
ifdef SERVICE
	$(DC) logs -f $(SERVICE)
else
	$(DC) logs -f
endif

shell: ## Start shell for one service, launch with SERVICE=<service>
ifndef SERVICE
	@echo "$(RED)Usage: make shell SERVICE=nom$(NC)"
	@echo "$(BLUE)Services:$(NC) $(SERVICES)"
else
	$(DC) exec $(SERVICE) /bin/bash || docker compose exec $(SERVICE) /bin/sh
endif

mysql: ## Shell MySQL/MariaDB
	$(DC) exec mariadb mysql -uroot -p

clean: ## Erase all services
	@echo "$(YELLOW)Nettoyage...$(NC)"
	$(DC) down -v --remove-orphans
## Erase all services
fclean: clean ## Erase all services
	@docker system prune -f

dev: build up logs ## Dev mode (build + up + logs)