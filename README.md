This project has been created as part of the 42 curriculum by raamorim.

Description:

    This project aims to introduce systems administration concepts using Docker and Docker Compose.

    In this project, we build a small infrastructure composed by some isolated services, each running his own container.

    The infrastructure includes:

        - NGINX container configured with HTTPS(TLSv1.2/TLSv1.3);
        - WordPress container running with PHP-FPM;
        - MariaDB container for database;
        - Docker volumes for data persistence;
        - A Docker network dedicated for internal comunication between services;

    Definition of Services:

        - NGINX - Server that receives browser requests and sends them to wordpress.
        - MariaDB - Database management system where WordPress data is stored.
        - Wordpress - Content management system that uses database to store content.It's the application that creates the site.

    Main concepts:

        - Docker:
            Containerization platform that allows packing aplications and dependencies (libraries, configs, etc), inside isolated container. With Docker applications run consistently across different enviroments, ensuring portability, scalability and reproducibility regardless of the host system.
        - Container:
            Isolated and lightweight unit that executes an application along with all its dependencies, sharing the host OS kernel. Containers start quickly, use fewer resources than virtual machines, and ensure the application runs consistently across different environments.
        - Docker Compose:
            It's a tool that allows to define and manage multi-containers applications using a "docker-compose.yml" file. This file specifies defines all servicies and how they're connected to each other.
        - Docker Image:
            It's an imutable template that contains instructions to build a container, including code, libraries, dependencies and configs. It's the blueprint used to create containers. Each service has is own image.
        - Dockerfile:
            It's an file containing sequencial instructions to build a docker image. It's like a "receipt" used to build an image.
        - Volume:
            Persistence data mecanism that stores data outside of the container's file system. Ex: If the container is removed, data isn't lost because it's stored outside of the container filesystem.
        - Network (Docker):
            Mecanism that allows isolated communication between containers. Private network where containers comunicate with each other.
        - TLS (Transport Layer Security):
            A cryptographic protocol that provides secure and encrypted communication between server and client. It's what turns HTTP into HTTPS.
        - Reverse-Proxy:
            Intermediare service that receives client requests and send them to one or more backend servers. Ex: User talks with NGINX and NGINX talks with Wordpress.

Instructions:

    - make :
        Build container and starts them.
    - make prep:
        Creates /home/raamorim/data/mariadb and /home/raamorim/data/wordpress
        Changes the permissions allowing Docker services to access and write data.
    - make build:
        - Uses 'prep'
        - Builds the Docker images for each service.
    - make up:
        Starts all docker services.
    - make down:
        Stop the infrastructure and removes the containers and networks created by Docker compose.
    - make clean:
        - Stops Docker services;
        - Cleans stopped containers, dangling images, unsed networks and build cache.Also removes ./src/data, wich contains persistent data such as database or Wordpress files.
    - make fclean:
        - Stops and removes all containers on the host.
        - Removes all images, volumes, and networks
        - Removes ./src/data completely.
    - make logs:
        - Shows the logs of a specific service.
    - make exec:
        - Enters a running container for interactive use.
    - make re:
        -Restarts the infrastructure.
        - Uses 'clean'
        - Uses 'build'
        - Uses 'up'.

    After the execution, website will be available at:
        - https://raamorim.42.fr


Project description:

    - Virtual Machines vs Docker:
        - VM - Each VM includes a full OS and virtual hardware. They're heavy and take longer to start.
        - Docker - Share the host OS kernel, start in seconds, use fewer resources and are more portable.

    - Design Choice:
		- Docker was chosen because it is lighter, faster, and more efficient than virtual machines, while still providing strong isolation between services.
	- VM was used to be done in a closed environment.
 
    - Secrets vs Environment Variables:
        - Secrets - Secure, only accessible inside the container, invisible in logs.
        - Environment Variables - Easy to use, but visible in logs.

    - Design Choice:
	- This project uses environment variables via a .env file for simplicity.
	- In production, Docker secrets are recommended for sensitive values like passwords or API keys.

    - Docker Network vs Host Network:
        - Docker Network - Containers comunicate in isolated virtual network.
        - Host Network - Shares host ports, faster but less secure.
	
    - Design Choice:
	- A Docker bridge network is used to isolate services while allowing controlled communication between them.

    - Docker Volumes vs Bind Mounts
        - Volumes - Managed by Docker, safe for persistent data.
        - Bind Mounts - Maps host folder, good for development, depenends on host.

    - Design Choice:
	- Subject doesn't allow bind mounts.


Resources:

    AI - Used to clarify theoretical concepts and review best practices.
    https://tuto.grademe.fr/inception/ - Provides a good guide to this project. Has clear explanations especially helpful for those starting the project.
    Youtube- Used to search what was Docker and how to use it.
    MariaDB Documentation - Used to learn how MariaDB works. 
    NGINX documentation - Used to learn how NGINX works.
    Docker documentation - Used to learn how Docker works.



