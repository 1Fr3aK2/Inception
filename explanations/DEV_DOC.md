# Developer Documentation

## Pré-requisitos

Antes de construir e executar o projeto Inception, certifique-se de que tem:

- Docker instalado
- Docker Compose instalado
- Máquina Virtual Linux (obrigatório pelo subject)
- Acesso à pasta do projeto com permissões corretas

## Estrutura de Diretórios

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
│   ├── db_password.txt
│   ├── db_root_password.txt
│   └── wp_admin_password.txt
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        ├── wordpress/
        └── mariadb/


secrets/: contém passwords e dados sensíveis (não versionados no Git)

srcs/: contém Dockerfiles, scripts, configuração e .env

Makefile: facilita a construção e gestão da infraestrutura

Configuração do Ambiente

Criar o ficheiro .env na pasta srcs/ com as variáveis de configuração:

DOMAIN_NAME=raamorim.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
WP_TITLE=Inception
WP_ADMIN_USER=raamorim42
WP_ADMIN_EMAIL=raamorim@student.42.fr
WP_USER=editor42
WP_USER_EMAIL=editor@student.42.fr


Criar as pastas de dados persistentes no host:

mkdir -p /home/raamorim/data/mariadb
mkdir -p /home/raamorim/data/wordpress


Colocar passwords nos ficheiros da pasta secrets/ conforme necessário.

Construção e Execução
Construir e iniciar os containers
make up


Constrói todas as imagens a partir dos Dockerfiles

Cria containers isolados

Liga os serviços pela network Docker interna

Parar a infraestrutura
make down

Rebuild completo (reset)
make re


Remove containers, volumes e imagens

Reconstrói tudo do zero

Comandos Úteis

Consultar containers ativos:

make ps


Consultar logs dos serviços em tempo real:

make logs


Entrar em qualquer container:

make exec c=<nome_container>
# exemplo: make exec c=nginx

Serviços e Ports
Serviço	Porta Externa	Porta Interna	Observações
NGINX	443	443	TLS 1.2/1.3, único ponto de entrada
WordPress	-	9000	PHP-FPM, comunica internamente com NGINX
MariaDB	-	3306	Acesso interno apenas (WordPress)
Gestão de Dados Persistentes

MariaDB: /var/lib/mysql → bind mount → /home/raamorim/data/mariadb

WordPress: /var/www/html → bind mount → /home/raamorim/data/wordpress

Garantia: dados persistem mesmo após parar ou remover containers.

Network

Nome: inception

Tipo: bridge

Permite:

Comunicação interna entre containers por nome do serviço

Isolamento do host

DNS interno automático

Configuração de Segurança

Todos os passwords estão fora do código (via .env e secrets)

TLS configurado apenas no NGINX (HTTPS obrigatório)

Containers isolados, sem uso de host network ou --link

Um container = um serviço, sem hacks de PID 1
