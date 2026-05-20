# 🐳 Inception

> A hardened multi-service infrastructure deployed with Docker Compose — built from scratch as part of the **42 School** curriculum.

![Language](https://img.shields.io/badge/language-Dockerfile-blue?style=flat-square)
![School](https://img.shields.io/badge/school-42-black?style=flat-square)
![Compose](https://img.shields.io/badge/docker--compose-v3-2496ED?style=flat-square)

---

## 📖 About

**Inception** introduces systems administration concepts through Docker and Docker Compose. The goal is to deploy a small, fully containerized infrastructure where each service runs in its own container — built entirely from custom Dockerfiles with no pre-built or official images allowed.

Security was a core concern throughout: TLS termination, network isolation, principle of least privilege, and documented awareness of credential management tradeoffs were all applied and reasoned through.

---

## 🏗️ Architecture

```
                        HTTPS (TLSv1.2/1.3)
Client ──────────────────────► NGINX (Reverse Proxy)
                                      │
                          Docker Bridge Network
                         ┌────────────┴────────────┐
                         ▼                         ▼
                    WordPress (PHP-FPM)         MariaDB
                         │                         │
                   Volume (wp-data)          Volume (db-data)
```

| Service   | Role                                                  |
|-----------|-------------------------------------------------------|
| NGINX     | Reverse proxy — handles TLS termination on port 443   |
| WordPress | CMS running with PHP-FPM, communicates with MariaDB   |
| MariaDB   | Database backend — no direct external exposure        |

---

## 🔐 Security Considerations

- **TLS 1.2/1.3 only** — older protocols disabled on NGINX; all traffic encrypted end-to-end
- **Network isolation** — services communicate over a dedicated Docker bridge network; only NGINX is exposed externally on port 443
- **Principle of least privilege** — each container runs only its required service with no unnecessary capabilities
- **No pre-built images** — every service built from a custom Dockerfile, giving full control over what runs inside each container
- **Credential management** — `.env` file used for simplicity; in production, Docker secrets would be preferred to avoid exposing sensitive values in logs

---

## 🗂️ Project Structure

```
Inception/
├── src/
│   ├── requirements/
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   ├── wordpress/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   └── mariadb/
│   │       ├── Dockerfile
│   │       └── conf/
│   └── docker-compose.yml
└── Makefile
```

---

## 🚀 Getting Started

### Prerequisites

- Docker
- Docker Compose
- `make`

### Build & Run

```bash
git clone https://github.com/1Fr3aK2/Inception.git
cd Inception
make
```

> After startup, the site is available at `https://raamorim.42.fr`

---

## 🧹 Makefile Targets

| Target       | Description                                                  |
|--------------|--------------------------------------------------------------|
| `make`       | Prepare data directories, build images, and start services   |
| `make build` | Build Docker images for each service                         |
| `make up`    | Start all services                                           |
| `make down`  | Stop and remove containers and networks                      |
| `make clean` | Stop services and remove containers, images, networks, cache |
| `make fclean`| Full teardown — removes all containers, images, volumes, data|
| `make re`    | Full restart (`clean` + `build` + `up`)                      |
| `make logs`  | Show logs for a specific service                             |
| `make exec`  | Enter a running container for interactive use                |

---

## 🧠 Design Decisions

**Docker over VM** — containers share the host OS kernel, start in seconds, and are more portable while still providing strong service isolation.

**Bridge network over host network** — containers communicate in an isolated virtual network rather than sharing host ports directly, reducing the attack surface.

**Volumes over bind mounts** — Docker-managed volumes are safer for persistent data and independent of the host filesystem structure. Bind mounts were explicitly disallowed by the project subject.

**Environment variables over Docker secrets** — `.env` used for simplicity within the scope of this project. The tradeoff (visibility in logs vs. security) was documented and understood.

---

## 👤 Author

- **[1Fr3aK2](https://github.com/1Fr3aK2)**
- Contributors visible in the [repository graph](https://github.com/1Fr3aK2/Inception/graphs/contributors)

---

## 📄 License

This project was developed for educational purposes at **42 School**. No explicit license has been applied — please refer to the school's academic integrity policy before reusing any code.

---

> *"Isolation is not just a container concept."*
