# ===========================
# Projeto Inception - 42
# Login: raamorim
# ===========================

# Caminho para o docker-compose
COMPOSE = docker compose -f srcs/docker-compose.yml

# Target padrão
all: up

# Constrói as imagens e sobe os containers
up:
	@echo "A construir imagens e a subir os containers..."
	@$(COMPOSE) up -d --build

# Para e remove os containers
down:
	@echo "A parar os containers..."
	@$(COMPOSE) down

# Remove containers, volumes e imagens (reset completo)
clean:
	@echo "A limpar containers, volumes e imagens..."
	@$(COMPOSE) down -v --rmi all

# Rebuild completo (clean + up)
re: clean up

# Mostra os containers ativos
ps:
	@$(COMPOSE) ps

# Mostra logs em tempo real
logs:
	@$(COMPOSE) logs -f

# Acede a um container (uso: make exec c=nginx)
exec:
	@docker exec -it $(c) bash

.PHONY: all up down clean re ps logs exec

