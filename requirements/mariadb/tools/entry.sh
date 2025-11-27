#!/bin/bash
# =========================================
# Script de inicialização do MariaDB/MySQL
# =========================================

# --------------------------------------------------------
# Verifica se o diretório do banco de dados existe
# --------------------------------------------------------
# OBS: Este teste não é totalmente correto, pois SQL_DB é o
# nome do banco de dados e não um diretório físico.
# Dependendo do caso, isso pode falhar.
if ! [ -d "$SQL_DB" ];  # "!" significa 'não'
then
    # ----------------------------------------------------
    # Inicia temporariamente o serviço MariaDB
    # ----------------------------------------------------
    service mariadb start

    # ----------------------------------------------------
    # Executa comandos SQL como usuário root (-u root)
    # -e permite passar o SQL diretamente na linha de comando
    # ----------------------------------------------------
    mariadb -u root -e "
    -- Cria o banco de dados se ainda não existir
    CREATE DATABASE IF NOT EXISTS $SQL_DB;

    -- Cria o usuário do banco se não existir, com acesso remoto ('%')
    CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASS';

    -- Concede todos os privilégios do banco para o usuário criado
    GRANT ALL PRIVILEGES ON $SQL_DB.* TO '$SQL_USER'@'%';

    -- Altera a senha do usuário root para o valor definido
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASS';

    -- Aplica imediatamente as alterações de privilégios
    FLUSH PRIVILEGES;

    -- Encerra o servidor MariaDB iniciado temporariamente
    SHUTDOWN;"
fi

# --------------------------------------------------------
# Inicia MariaDB de forma segura e aceitando conexões externas
# --bind-address=0.0.0.0 permite que outros hosts acessem
# --------------------------------------------------------
mysqld_safe --bind-address=0.0.0.0

