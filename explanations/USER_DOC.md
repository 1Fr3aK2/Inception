# User Documentation

## Visão Geral dos Serviços

Este projeto disponibiliza uma infraestrutura Docker composta pelos seguintes serviços:

- Website WordPress acessível por HTTPS
- Painel de administração do WordPress
- Base de dados MariaDB (acesso interno apenas)

Todos os serviços são executados em containers Docker separados
e comunicam entre si através de uma network Docker dedicada.

## Iniciar e Parar o Projeto

### Iniciar a Infraestrutura

Para construir as imagens e iniciar os serviços, execute:
```bash
make up
```

### Parar a Infraestrutura

Para parar todos os serviços em execução:
```bash
make down
```

## Acesso ao Website e Painel de Administração

- Website:
  ```
  https://raamorim.42.fr
  ```

- Painel de administração do WordPress:
  ```
  https://raamorim.42.fr/wp-admin
  ```

## Gestão de Credenciais

As credenciais do projeto são geridas de forma segura através de:

- Variáveis de ambiente definidas no ficheiro `.env`
- Ficheiros de secrets armazenados localmente (fora do repositório Git)

Nenhuma password ou informação sensível está presente
nos Dockerfiles ou no código-fonte do projeto.

## Verificação do Estado dos Serviços

Para verificar se os containers estão a correr corretamente:
```bash
make ps
```

Para consultar os logs dos serviços:
```bash
make logs
```

## Persistência de Dados

Os dados do projeto são persistentes e armazenados no host nas seguintes localizações:

- Dados da base de dados MariaDB:
  ```
  /home/raamorim/data/mariadb
  ```

- Ficheiros do WordPress:
  ```
  /home/raamorim/data/wordpress
  ```

Estes dados permanecem intactos mesmo após parar ou reiniciar
os containers Docker.
