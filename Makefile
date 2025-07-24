# Config
PROJECT_NAME	?= $(shell basename $(CURDIR))
SERVICES		= $(shell docker compose $(DC_FILE) config --services 2>/dev/null || echo "")
DC_FILE			= /home/vmaelatmi/Inception/srcs/docker-compose.yml
DC				= @docker compose

# Colors
GREEN			= \033[0;32m
YELLOW			= \033[1;33m
RED				= \033[0;31m
BLUE			= \033[0;34m
NC				= \033[0m

.PHONY: help up down restart build logs shell clean status

help: ## Afficher l'aide
	@echo "$(GREEN)🐳 $(PROJECT_NAME)$(NC)"
	@echo ""
	@echo "$(BLUE)Services:$(NC) $(SERVICES)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(RED)⚠️  N'oubliez pas de créer votre fichier .env !$(NC)"

up: ## Démarrer les services
	@echo "$(GREEN)Démarrage des services...$(NC)"
	$(DC) up $(DC_FILE)
	@make status

down: ## Arrêter les services
	@echo "$(YELLOW)Arrêt des services...$(NC)"
	$(DC) down $(DC_FILE)

restart: ## Redémarrer les services
ifdef SERVICE
	$(DC) restart $(SERVICE)
else
	$(DC) restart
endif

build: ## Construire les images
	@echo "$(GREEN)Construction des images...$(NC)"
	$(DC) build $(DC_FILE)

rebuild: down build up ## Tout reconstruire

status: ## Statut des services
	@echo "$(BLUE)Statut:$(NC)"
	$(DC) ps

logs: ## Voir les logs
ifdef SERVICE
	$(DC) logs -f $(SERVICE)
else
	$(DC) logs -f
endif

shell: ## Accéder au shell d'un service
ifndef SERVICE
	@echo "$(RED)Usage: make shell SERVICE=nom$(NC)"
	@echo "$(BLUE)Services:$(NC) $(SERVICES)"
else
	$(DC) exec $(SERVICE) /bin/bash || docker compose $(DC_FILE) exec $(SERVICE) /bin/sh
endif

mysql: ## Shell MySQL/MariaDB
	$(DC) exec mariadb mysql -uroot -p

clean: ## Nettoyer
	@echo "$(YELLOW)Nettoyage...$(NC)"
	$(DC) down -v $(DC_FILE)
	@docker system prune -f

dev: build up logs ## Mode dev (build + up + logs)