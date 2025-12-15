*This project has been created as part of the 42 curriculum by raamorim.*

# Inception

## Description

O projeto Inception tem como objetivo introduzir conceitos de administração de sistemas
através da utilização de Docker e Docker Compose.

Consiste na criação de uma pequena infraestrutura composta por vários serviços isolados,
cada um a correr no seu próprio container Docker, respeitando regras estritas de segurança,
isolamento, persistência de dados e boas práticas.

A infraestrutura implementada inclui:
- Um container NGINX como único ponto de entrada, configurado com HTTPS (TLSv1.2 / TLSv1.3)
- Um container WordPress com PHP-FPM (sem nginx)
- Um container MariaDB para a base de dados
- Volumes Docker para persistência dos dados
- Uma network Docker dedicada para comunicação interna entre serviços

Todo o projeto é executado numa máquina virtual, conforme exigido pelo subject.

## Instructions

### Requisitos

- Docker
- Docker Compose
- Máquina Virtual Linux

### Instalação e Execução

Para construir as imagens e iniciar os containers:
```bash
make up

Para parar a infraestrutura:

make down


Para reconstruir tudo do zero:

make re


Após a execução, o website estará disponível em:

https://raamorim.42.fr

Project Design Choices
Virtual Machines vs Docker

Máquinas Virtuais virtualizam um sistema operativo completo.

Docker virtualiza apenas processos e dependências.

Docker é mais leve, rápido e consome menos recursos.

Este projeto utiliza Docker por ser mais adequado a micro-serviços.

Secrets vs Environment Variables

Variáveis de ambiente são usadas para configuração geral.

Dados sensíveis (passwords) são armazenados fora do código, através de secrets.

Evita-se qualquer hardcoding de credenciais no repositório.

Docker Network vs Host Network

Docker Network permite isolamento e comunicação interna segura.

Host Network expõe diretamente os serviços ao host.

O uso de host network é proibido pelo subject.

Docker Volumes vs Bind Mounts

Volumes garantem persistência de dados.

Bind mounts permitem acesso direto aos dados no host.

Este projeto utiliza bind mounts para cumprir o requisito
de persistência em /home/raamorim/data.

Resources

Docker Documentation

Docker Compose Documentation

NGINX Official Documentation

WordPress Codex

MariaDB Documentation

Uso de Inteligência Artificial

Ferramentas de IA foram utilizadas como apoio para:

Esclarecimento de conceitos teóricos

Organização da documentação

Revisão de boas práticas

Todo o conteúdo foi analisado, compreendido e validado manualmente,
sendo o autor totalmente responsável pelo projeto.

