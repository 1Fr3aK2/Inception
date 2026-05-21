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
├── DOCS/
│   ├── DEV_DOC.md          # Developer documentation
│   └── USER_DOC.md         # User documentation
├── src/
│   ├── .env                # Environment variables (not committed)
│   ├── docker-compose.yml
│   └── requirements/
│       ├── nginx/
│       │   ├── Dockerfile
│       │   └── conf/
│       ├── wordpress/
│       │   ├── Dockerfile
│       │   └── conf/
│       └── mariadb/
│           ├── Dockerfile
│           └── conf/
└── Makefile
```

---

## 🚀 Getting Started

### 1. Install Docker

**Ubuntu / Debian**

Remove any old versions first:
```bash
sudo apt remove docker docker-engine docker.io containerd runc
```

Install dependencies:
```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
```

Add Docker's official GPG key and repository:
```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Install Docker Engine and Compose plugin:
```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Verify the installation:
```bash
docker --version
docker compose version
```

**macOS**

Download and install [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/). Docker Compose is included.

**Allow running Docker without `sudo` (Linux only)**

```bash
sudo usermod -aG docker $USER
newgrp docker
```

> Log out and back in for the changes to take effect.

---

### 2. Install `make`

```bash
# Ubuntu / Debian
sudo apt install -y make

# macOS (with Homebrew)
brew install make
```

---

### 3. Clone the Repository

```bash
git clone https://github.com/1Fr3aK2/Inception.git
cd Inception
```

---

### 4. Configure the Environment

Create the `.env` file inside `src/`:

```bash
touch src/.env
```

Add the following variables:

```env
DOMAIN_NAME=raamorim.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
WP_TITLE=Inception
WP_ADMIN_USER=raamorim42
WP_ADMIN_EMAIL=student.42.fr
WP_USER=editor42
WP_USER_EMAIL=raamorim1@student.42.fr
```

> Passwords and secrets should be added separately and never committed to version control.

---

### 5. Build and Run

```bash
make
```

---

## 🌐 Accessing the Services

| URL | Description |
|-----|-------------|
| `https://raamorim.42.fr` | WordPress website |
| `https://raamorim.42.fr/wp-admin` | WordPress administration panel |

> MariaDB is internal only — it is not accessible from outside the Docker network.

---

## 🧹 Makefile Targets

| Target        | Description                                                          |
|---------------|----------------------------------------------------------------------|
| `make`        | Prepare data directories, build images, and start services           |
| `make prep`   | Create required data directories and set correct permissions         |
| `make build`  | Build Docker images for each service                                 |
| `make up`     | Start all Docker services                                            |
| `make down`   | Stop and remove containers and networks                              |
| `make clean`  | Stop services and remove containers, images, networks, cache and data|
| `make fclean` | Full teardown — removes all containers, images, volumes, networks and data |
| `make re`     | Full restart (`clean` + `build` + `up`)                              |
| `make logs`   | Show logs for a specific service                                     |
| `make exec`   | Enter a running container for interactive use                        |

---

## 🔧 Useful Docker Commands

**Check running containers:**
```bash
docker ps
```

**View logs for a specific service:**
```bash
make logs SERVICE=<container-name>
# or
docker logs <container-name>
```

**Enter a running container:**
```bash
make exec SERVICE=<container-name>
# or
docker exec -it <container-name> sh
```

**List all images:**
```bash
docker image ls
```

**List all volumes:**
```bash
docker volume ls
```

---

## 💾 Data Persistence

Project data is stored in:

| Path | Contents |
|------|----------|
| `./src/data/db` | MariaDB database files |
| `./src/data/wordpress` | WordPress site files |

Docker volumes ensure that data survives container restarts and rebuilds. Be aware:

- `make clean` — removes containers and cache **and also deletes** `./src/data`
- `make fclean` — removes everything: containers, images, volumes, networks, and `./src/data`

---

## 🧠 Design Decisions

**Docker over VM** — containers share the host OS kernel, start in seconds, and are more portable while still providing strong service isolation. A VM was used as the closed environment required by the project subject.

**Bridge network over host network** — containers communicate in an isolated virtual network rather than sharing host ports directly, reducing the attack surface.

**Volumes over bind mounts** — Docker-managed volumes are safer for persistent data and independent of the host filesystem structure. Bind mounts were explicitly disallowed by the project subject.

**Environment variables over Docker secrets** — `.env` used for simplicity within the scope of this project. The tradeoff (visibility in logs vs. security) was documented and understood.

---

## 👤 Author

- **[raamorim](https://github.com/1Fr3aK2)**
- Contributors visible in the [repository graph](https://github.com/1Fr3aK2/Inception/graphs/contributors)

---

## 📄 License

This project was developed for educational purposes at **42 School**. No explicit license has been applied — please refer to the school's academic integrity policy before reusing any code.

---

> *"Isolation is not just a container concept."*
