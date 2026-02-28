Overview of Services:

    - This project provides a Docker infrastructure composed of the following services:
        - WordPress website acessible via HTTPS.
        - WordPress Administration painel.
        - MariaDB database (internal acess only).
    
    All these services run in separated Docker containers and comunicate with each other through dedicated Docker network.

Start and stop the project:

    make
        - builds the containers and starts the infrastructure.

    make prep
        - creates the required data directories and sets the correct permissions.

    make build
        - prepares the environment and builds all Docker images.

    make up
        - starts all Docker services.

    make down
        - stops the infrastructure and removes containers and networks.

    make clean
        - stops services and removes unused containers, images, networks, cache and project data.

    make fclean
        - removes all containers, images, volumes, networks and project data from the host.

    make logs
        - displays the logs of a specific service.

    make exec
        - opens an interactive shell inside a running container.

    make re
        - rebuilds and restarts the entire infrastructure.


Access the website and the administration panel:

    - To acess Website:
        - https://raamorim.42.fr
    - To acess administration panel:
        - https://raamorim.42.fr/wp-admin

Locate and manage credentials:

    The project credentials are managed securely using:
        - Environment variables defined in .env file, located at ./src/.env .

Check that the services are running correctly:

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

