
---
title: "Homelab : Stockage et Hébergement"
date: 2025-01-06
draft: false
tags: ["storage", "postgres", "gitea", "docker", "ftp", "homelab"]
---

Après avoir mis en place le monitoring et la supervision, une étape tout aussi essentielle pour mon homelab est la mise en place d’un système de stockage fiable et adapté à mes besoins. Mon infrastructure repose sur quatre piliers principaux :
- **PostgreSQL** pour la gestion des vecteurs et autres données applicatives.
- **Gitea** pour l’hébergement de mon code et l’intégration CI/CD.
- **Docker Registry** pour un stockage léger et efficace des images Docker.
- **Stockage FTP** sur mon NAS Synology pour héberger datasets, modèles et autres fichiers nécessaires.

Dans cet article, je vais détailler mon approche et les outils utilisés.

## PostgreSQL : Une Base Solide pour Mes Applications

PostgreSQL est un choix naturel pour mon homelab car il combine robustesse, extensibilité et la capacité de gérer des vecteurs via l’extension `pgvector`. Cela s’intègre parfaitement dans mes applications, notamment celles orientées machine learning.

### Déploiement avec Docker

L’installation est automatisée avec Ansible et utilise une image Docker spécifique pour `pgvector`.

```yaml
- name: Ensure Docker service is running
  service:
    name: docker
    state: started
    enabled: yes

- name: Pull PostgreSQL Docker image
  docker_image:
    name: pgvector/pgvector:pg17
    source: pull

- name: Create PostgreSQL container
  docker_container:
    name: postgres_db
    image: pgvector/pgvector:pg17
    state: started
    restart_policy: always
    env:
      POSTGRES_DB: "mydatabase"
      POSTGRES_USER: "myuser"
      POSTGRES_PASSWORD: "mypassword"
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
```

### Interface de Gestion : pgAdmin

pgAdmin complète cette configuration en offrant une interface graphique pour gérer la base de données.

```yaml
- name: Pull pgAdmin Docker image
  docker_image:
    name: dpage/pgadmin4:latest
    source: pull

- name: Create pgAdmin container
  docker_container:
    name: pgadmin
    image: dpage/pgadmin4:latest
    state: started
    restart_policy: always
    env:
      PGADMIN_DEFAULT_EMAIL: "admin@example.com"
      PGADMIN_DEFAULT_PASSWORD: "admin"
    ports:
      - "8081:80"
    volumes:
      - pgadmin_data:/var/lib/pgadmin
```

Cela me donne une interface accessible n'importe où (après redirection par mon proxy) :

![images](/pgadmin.png)

## Gitea : Hébergement et CI/CD

Gitea est un choix parfait pour mon homelab :
- Léger et rapide
- Intégré à Docker pour simplifier la gestion
- Idéal pour héberger mes projets et gérer mes pipelines CI/CD

### Déploiement avec PostgreSQL

```yaml
- name: Pull Gitea Docker image
  docker_image:
    name: gitea/gitea:latest
    source: pull

- name: Create Gitea container
  docker_container:
    name: gitea
    image: gitea/gitea:latest
    state: started
    restart_policy: always
    env:
      GITEA__database__DB_TYPE: postgres
      GITEA__database__HOST: postgres_db:5432
      GITEA__database__NAME: "exampledb"
      GITEA__database__USER: "exampleuser"
      GITEA__database__PASSWD: "********"
      GITEA__server__DOMAIN: "gitea.example.com"
    ports:
      - "3000:3000"
    volumes:
      - gitea_data:/data
```

![images](/gitea.png)

## Docker Registry : Stockage d’Images Conteneur

Le Docker Registry est une solution légère et efficace pour stocker et partager les images Docker nécessaires à mes projets.

```yaml
- name: Pull Docker Registry image
  docker_image:
    name: registry:latest
    source: pull

- name: Create Docker Registry container
  docker_container:
    name: docker_registry
    image: registry:2
    state: started
    restart_policy: always
    ports:
      - "5000:5000"
    volumes:
      - registry_data:/var/lib/registry
```

## Stockage FTP sur NAS Synology

Pour le stockage des fichiers volumineux comme les datasets et modèles ML, j’utilise un serveur FTP sur mon NAS Synology. Ce choix est motivé par la simplicité et la compatibilité du protocole FTP avec de nombreux outils.

## Conclusion

Ce système de stockage me permet de :
- Gérer efficacement mes données avec PostgreSQL.
- Héberger mon code et exécuter des pipelines CI/CD avec Gitea.
- Maintenir un registre Docker simple et performant.
- Stocker et accéder facilement aux fichiers via FTP.
