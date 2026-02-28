COMPOSE = docker compose -f ./src/docker-compose.yml
VOLUMES = /home/raamorim/data/mariadb /home/raamorim/data/wordpress
SERVICES = wordpress mariadb nginx

all: clean build up
	@echo "Started !!"

prep:
	@echo "Buildind volumes directories..."
	mkdir -p $(VOLUMES)
	sudo chown -R 999:999 $(VOLUMES)
	sudo chmod -R 755 $(VOLUMES)
	
	
build: prep
	@echo "Building images..."
	$(COMPOSE) build

up:
	@echo "Upping all the containers..."
	$(COMPOSE) up -d

down:
	@echo "Stoping and removing containers..."
	$(COMPOSE) down -v

clean:
	@echo "Cleaning Docker..."
	$(COMPOSE) down -v
	docker system prune -f
	sudo rm -rf $(VOLUMES)

fclean:
	@echo "Full cleaning Docker..."
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q) 2>/dev/null	

logs:
	@echo "Check specific service logs (ex: make logs SERVICE=wordpress)"
	$(COMPOSE) logs -f $(SERVICE)


exec:
	@echo "Entering on the container (ex: make exec SERVICE=mariadb)"
	$(COMPOSE) exec $(SERVICE) sh

re: clean build up
	@echo "Restarting all the containers..."

.PHONY: all build up down clean fclean logs exec restart prep
