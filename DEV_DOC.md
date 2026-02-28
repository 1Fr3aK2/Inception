Prerequisites: 

    - Before building and running the project, make sure you have:
        - Docker installed
        - Docker Compose installed
        - Linux Virtual Machine
        - Acess to the project folder with right permissions.

    - Configuration files:
        - Create this files:
            - ./src/docker-compose.yml
            - ./src/.env

    - Directory Structure:
        .
        ├── Makefile
        ├── README.md
        ├── USER_DOC.md
        ├── DEV_DOC.md
        └── src/
            ├── .env
            ├── docker-compose.yml
            └── requirements/
                ├── nginx/
                ├── wordpress/
                └── mariadb/

    src/: contains Dockerfiles, scripts, configuration files, and .env.
    Makefile: facilitates building and managing the infrastructure.

    Create the .env file in the src/ folder with the configuration variables:
        DOMAIN_NAME=raamorim.42.fr
        MYSQL_DATABASE=wordpress
        MYSQL_USER=wpuser
        WP_TITLE=Inception
        WP_ADMIN_USER=raamorim42
        WP_ADMIN_EMAIL=student.42.fr
        WP_USER=editor42
        WP_USER_EMAIL=raamorim1@student.42.fr

Build and launch the project:

    - Build the project (Container images ...) : make up
    - Start all services: make up
    - Stop the services: make down
    - Rebuild and restart (clean + build + up): make re

Use relevant commands to manage the containers and volumes:

    - To verify if the containers are running correctly:
        - docker ps.
    - To consult the logs of the service:
        - make logs SERVICE=<container name/id>
        - docker logs <contianer name/id>
    - To enter inside container:
        - make exec SERVICE=<container name/id>
        - docker exec -it <container name/id> sh
    - To check images:
        - docker images ls
    - To check Docker volumes:
        - docker volume ls

Identify where the project data is stored and how it persists:
    
    - Project data is stored in:
        - ./src/data/db -> MariaDB database files
        - ./src/data/wordpress -> WordPress files
    
    - Data persistence:
        - Docker volumes ensure that database and WordPress files survive container restarts or rebuilds.
        - make clean removes the project containers and caches but also deletes ./src/data.
        - make fclean removes all containers, images, volumes, networks, and ./src/data.
