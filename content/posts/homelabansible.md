---
title: "Automatiser mon Homelab avec Ansible et Docker Compose"
date: 2024-10-22
draft: false
tags: ["self-hosted", "homelab"]
---

Dans cet article, je vais vous présenter une partie de mon homelab, orchestré avec Ansible pour la configuration automatique et Docker Compose pour le déploiement des services. Le projet complet est disponible sur mon [GitHub](https://github.com/nathanlq/homelab-ansible), n'hésitez pas à y jeter un œil si vous voulez l'essayer ou vous en inspirer pour votre propre setup.

## Structure du Projet

Mon projet Ansible se compose d'un playbook principal, d'un inventory pour gérer mes hôtes, et de plusieurs roles qui représentent différentes tâches à accomplir. Voici à quoi ressemble la structure de l'arborescence :

```bash
.
├── docker-compose.yml
├── inventory
├── playbook.yml
└── roles
    ├── check_docker_compose
    ├── docker
    ├── initial_config
    ├── monitoring
    └── vsftpd
```

Les rôles sont utilisés pour découper les tâches logiques en différentes étapes, par exemple :

- check_docker_compose : vérifier si Docker Compose est installé.
- docker : installer Docker et le configurer.
- initial_config : configuration initiale du réseau et de la machine.
- monitoring : configurer Prometheus et Grafana pour surveiller les services.
- vsftpd : configurer un serveur FTP sécurisé avec vsftpd.

Chaque rôle est structuré avec des tasks, des templates et des vars, pour gérer les actions, les fichiers de configuration à déployer et les variables nécessaires.

## Docker Compose : Orchestration des Services

Le fichier docker-compose.yml est la pièce maîtresse de mon déploiement. Il contient plusieurs services essentiels que j'auto-héberge sur mon homelab :

```bash
version: '3.8'
services:
  nginx-proxy-manager:
    image: 'jc21/nginx-proxy-manager:latest'
    ports:
      - '80:80'
      - '443:443'
      - '81:81'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt

  portainer:
    image: portainer/portainer-ce:2.21.2
    ports:
      - '8000:8000'
      - '9443:9443'
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

  # Autres services : Vaultwarden, Redis, Forgejo, Grafana, Prometheus, Heimdall
```

Les services principaux déployés via Docker sont les suivants :

- Nginx Proxy Manager : gère les redirections et les certificats SSL.
- Portainer : interface graphique pour la gestion de mes conteneurs Docker.
- Vaultwarden : gestionnaire de mots de passe auto-hébergé.
- Redis Stack : base de données en mémoire avec des extensions pour le cache et la persistance.
- Forgejo : une forge Git auto-hébergée (basée sur Gitea).
- Grafana et Prometheus : ensemble pour la supervision de l'infrastructure.
- Heimdall : tableau de bord pour gérer facilement l’accès à tous les services.

## Gestion des Variables

L'un des aspects importants de ce setup est la gestion des variables sensibles, comme les mots de passe ou les identifiants d'utilisateur. Ces informations sont stockées dans des fichiers de variables séparés pour chaque rôle. Par exemple, dans docker/vars/main.yml :

```bash
redis_password: 'votre-mot-de-passe-redis'
gf_security_admin_password: 'mot-de-passe-admin-grafana'
```

## Monitoring avec Prometheus et Grafana

Pour surveiller mon homelab, j'utilise Prometheus et Grafana. Prometheus collecte des métriques depuis tous les services et les expose dans un fichier de configuration, défini dans le rôle monitoring :

```bash
roles/monitoring/files/prometheus.yml
```

Ensuite, Grafana visualise ces données via un joli tableau de bord, ce qui me permet de surveiller en temps réel l'état de mes conteneurs, les performances réseau, et plus encore.

## Conclusion

Ce setup me permet d’avoir un homelab auto-hébergé, stable, et facile à maintenir. Grâce à Ansible, je peux provisionner des machines rapidement et configurer l’ensemble de mes services en un seul playbook, tandis que Docker Compose orchestre tous les conteneurs. Si vous êtes intéressé par l’auto-hébergement ou cherchez à simplifier la gestion de vos services avec des outils comme Ansible et Docker, je vous invite à tester ce projet et à l’adapter à vos besoins.

Voilà pour cet article sur la configuration d'Ansible dans mon homelab ! Pour plus de détails et accéder à tout le code, rendez-vous sur mon dépôt [GitHub](https://github.com/nathanlq/homelab-ansible).