---
title: "Homelab : Outils et Choix d’Hébergement"
date: 2024-12-01
draft: false
tags: ["self-hosted", "homelab"]
---

Avec mon homelab, mon objectif est de créer un environnement flexible, scalable et automatisé, couvrant des besoins variés : développement, stockage, monitoring, et auto-hébergement de services personnels. Voici une présentation des choix technologiques et de la structure que j'ai adoptés pour répondre à ces besoins.

## Architecture

Mon homelab se compose de quatre éléments principaux :
1. **Routeur** : Héberge une petite VM avec des services réseau essentiels.
2. **Serveur avec GPU (Proxmox)** : Conçu pour des tâches exigeantes comme l’hébergement de modèles IA, le développement, et les services gourmands en calcul.
3. **Serveur sans GPU (Proxmox)** : Optimisé pour l’automatisation, le monitoring, et le stockage rapide (Redis, bases de données).
4. **NAS Synology** : Principalement utilisé pour le stockage et quelques services légers.

### Objectifs principaux
- Centraliser mes services avec une gestion simplifiée.
- Automatiser les configurations pour faciliter les déploiements futurs.
- Exploiter des outils modernes pour l’efficacité et la sécurité.

Le but n'est pas d'en faire trop mais de créer un environnement de développement que je controle parfaitement et qui ne se met pas en travers de mon chemin, avec en bonus des services qui pourront améliorer mon confort et me permettre d'éviter d'utiliser des logiciels propriétaires.

## Infrastructure et Services Hébergés

### **Routeur : Sécurité et Réseau**
- [**Nginx Proxy Manager**](https://nginxproxymanager.com/) : Reverse proxy pour gérer les certificats SSL et la répartition des requêtes.
- [**Wireguard**](https://www.wireguard.com/) : VPN pour accéder à distance à mon homelab en toute sécurité.

### **Serveur avec GPU : Hébergement IA**
- **Hébergement de LLM** : Déploiement de modèles comme Starcoder ou Mistral pour des projets liés à l’IA.

### **Serveur sans GPU : Automatisation et Monitoring**
- [**Gitea**](https://about.gitea.com/) : Code hosting et CI/CD auto-hébergé pour gérer mes projets.
- **[Prometheus](https://prometheus.io/) & [Grafana](https://grafana.com/)** : Monitoring complet pour surveiller l'état des services et des ressources.
- [**Redis**](https://redis.io/fr/) : Base de données en mémoire pour des performances rapides.
- **[Docker](https://www.docker.com/) avec [Portainer](https://www.portainer.io/)** : Gestion des conteneurs via une interface intuitive.

### **NAS Synology : Stockage et Services Légers**
Le NAS n'éberge que le stockage, configuré NFS pour marcher avec mon hyperviseur Proxmox, les conteneurs tournent sur mon serveurs sans GPU.
- [**Container Registry**](https://hub.docker.com/_/registry) : Stockage centralisé pour les images Docker.
- **[PostgreSQL](https://www.postgresql.org/) avec [pgvector](https://github.com/pgvector/pgvector)** : Gestion de données sql classique et vectorielles pour des applications ML.
- [**Synology Drive**](https://www.synology.com/fr-fr/dsm/feature/drive) : Synchronisation des fichiers comme alternative à Google Drive.
- **FTP et Rsync** : Gestion des transferts et sauvegardes de fichiers.

## Automatisation avec Ansible et Docker Compose

Pour orchestrer l'ensemble de cette infrastructure, j'utilise [**Ansible**](https://docs.ansible.com/) pour l’automatisation et [**Docker Compose**](https://docs.docker.com/compose/) pour le déploiement des services. Grâce à ces outils :
- Les configurations sont uniformisées et reproductibles.
- Les services peuvent être rapidement réinstallés en cas de problème.
- Les variables sensibles (mots de passe, clés API) sont gérées séparément dans des fichiers sécurisés.

## Page d’Accueil et Accessibilité

Tous les services sont accessibles depuis une page d’accueil centralisée ([Glances](https://github.com/nicolargo/glances)), hébergée derrière le reverse proxy. Cette page liste tous les services avec des liens directs, des icônes et des descriptions, facilitant leur utilisation quotidienne.