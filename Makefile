DC_FILE			= ./srcs/docker-compose.yml
DC				= @docker compose -f $(DC_FILE)

all: build up

up:
	@mkdir -p /home/vmaelatmi/data/wordpress_data /home/vmaelatmi/data/mariadb_data
	$(DC) up -d

down:
	$(DC) down

restart:
	$(DC) restart

build:
	$(DC) build

fre: fclean all

re: clean all

clean: down
	$(DC) down -v --remove-orphans
	sudo rm -rf /home/vmaelatmi/data/mariadb_data/*
	sudo rm -rf /home/vmaelatmi/data/wordpress_data/*

fclean: clean
	@docker system prune -af --volumes

#DEBUG SECTION
status:
	$(DC) ps
	$(DC) volumes

psaux:
	@echo "--- mariadb ps aux ---"
	docker exec -it mariadb ps aux
	@echo "--- wordpress ps aux ---"
	docker exec -it wordpress ps aux
	@echo "--- nginx ps aux ---"
	docker exec -it nginx ps aux

logs:
	@echo "--- mariadb logs ---"
	$(DC) logs mariadb
	@echo "--- wordpress logs ---"
	$(DC) logs wordpress
	@echo "--- nginx logs ---"
	$(DC) logs nginx

#
.PHONY: all fre re up down restart build logs clean fclean status psaux