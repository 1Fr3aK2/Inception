# Inception

> 42 Lisboa — Systems Administration with Docker

Deployed a hardened multi-service infrastructure (NGINX + WordPress + MariaDB) using Docker Compose with no pre-built images, enforcing network security by configuring TLS 1.2/1.3 termination on NGINX, isolating inter-service communication via a dedicated bridge network, and applying principle of least privilege per container — with documented awareness of the security tradeoff between Docker secrets and environment variables.

---

## Architecture

```
                        HTTPS (TLSv1.2/1.3)
Client ──────────────────────► NGINX (Reverse Proxy)
                                      │
                          Docker Bridge Network
                         ┌────────────┴────────────┐
                         ▼                         ▼
                    WordPress (PHP-FPM)        MariaDB
                         │                         │
                    Volume (wp-data)         Volume (db-data)
```

| Service   | Role                                      |
|-----------|-------------------------------------------|
| NGINX     | Reverse proxy with TLS termination        |
| WordPress | CMS with PHP-FPM, communicates with DB    |
| MariaDB   | Database backend, no external exposure    |

---

## Security Considerations

**TLS 1.2/1.3 only** — older protocols disabled on NGINX, all traffic encrypted end-to-end.

**Network isolation** — services communicate over a dedicated Docker bridge network. No service is directly exposed except NGINX on port 443.

**Principle of least privilege** — each container runs only its required service, built from a custom Dockerfile with no pre-built or official images.

**Credentials management** — environment variables via `.env` file. In production, Docker secrets would be preferred to avoid credential exposure in logs.

**No bind mounts** — Docker volumes used for data persistence, keeping host filesystem isolated from container data.

---

## Design Decisions

**Docker over VM** — containers share the host OS kernel, start in seconds, and are more portable while still providing strong service isolation.

**Bridge network over host network** — containers communicate in an isolated virtual network rather than sharing host ports directly, reducing the attack surface.

**Volumes over bind mounts** — Docker-managed volumes are safer for persistent data and independent of the host filesystem structure.

---

## Usage

```bash
# Build images and start all services
make

# Start services (after build)
make up

# Stop and remove containers and networks
make down

# Full clean (containers, images, volumes, networks, data)
make fclean

# Restart infrastructure
make re

# View logs for a specific service
make logs

# Enter a running container
make exec
```

> After startup, the site is available at `https://raamorim.42.fr`

---

## Project Structure

```
Inception/
├── src/
│   ├── requirements/
│   │   ├── nginx/
│   │   │   └── Dockerfile
│   │   ├── wordpress/
│   │   │   └── Dockerfile
│   │   └── mariadb/
│   │       └── Dockerfile
│   └── docker-compose.yml
└── Makefile
```

---

## Key Concepts

**Docker** — containerization platform that packages applications and their dependencies into isolated, reproducible environments.

**Docker Compose** — defines and manages multi-container applications via a single `docker-compose.yml` file.

**Reverse Proxy** — NGINX sits between the client and backend services, handling TLS termination and routing requests to WordPress.

**TLS (Transport Layer Security)** — cryptographic protocol that encrypts communication between client and server, turning HTTP into HTTPS.

**Docker Volumes** — persist data outside the container filesystem, surviving container restarts and removals.

---

*42 Lisboa — raamorim*
