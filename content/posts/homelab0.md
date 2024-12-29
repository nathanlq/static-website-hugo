---
title: "Homelab : Outils et Choix d’Hébergement"
date: 2024-12-01
draft: false
tags: ["self-hosted", "homelab"]
---

Avec mon homelab, mon objectif est de créer un environnement flexible, scalable et automatisé, couvrant des besoins variés : développement, stockage, monitoring, et auto-hébergement de services personnels. Voici une présentation des choix technologiques et de la structure que j'ai adoptés pour répondre à ces besoins.

## Nouvelle Architecture

Mon homelab se compose de quatre éléments principaux :
1. **Routeur** : Héberge une petite VM avec des services réseau essentiels.
2. **Serveur avec GPU (Proxmox)** : Conçu pour des tâches exigeantes comme l’hébergement de modèles IA, le développement, et les services gourmands en calcul.
3. **Serveur sans GPU (Proxmox)** : Optimisé pour l’automatisation, le monitoring, et le stockage rapide (Redis, bases de données).
4. **NAS Synology** : Principalement utilisé pour le stockage et quelques services légers.

### Objectifs principaux
- Centraliser mes services avec une gestion simplifiée.
- Automatiser les configurations pour faciliter les déploiements futurs.
- Exploiter des outils modernes pour l’efficacité et la sécurité.

## Infrastructure et Services Hébergés

### **Routeur : Sécurité et Réseau**
- **Nginx Proxy Manager** : Reverse proxy pour gérer les certificats SSL et la répartition des requêtes.
- **Pi-Hole** : DNS local avec blocage publicitaire.
- **Fail2Ban** : Protection contre les attaques réseau, filtrage d'IP malveillantes.
- **Wireguard** : VPN pour accéder à distance à mon homelab en toute sécurité.

### **Serveur avec GPU : Développement et Hébergement IA**
- **VSCode Server** : IDE accessible depuis le navigateur, idéal pour coder à distance.
- **JupyterHub** : Plateforme collaborative pour le développement avec des notebooks.
- **Hébergement de LLM** : Déploiement de modèles comme Starcoder ou Mistral pour des projets liés à l’IA.

### **Serveur sans GPU : Automatisation et Monitoring**
- **Sourcehut** : Code hosting et CI/CD auto-hébergé pour gérer mes projets.
- **Prometheus & Grafana** : Monitoring complet pour surveiller l'état des services et des ressources.
- **Redis** : Base de données en mémoire pour des performances rapides.
- **LSO (Lightweight Orchestrator)** : Orchestration légère pour la gestion des services et workflows.
- **Docker avec Portainer** : Gestion des conteneurs via une interface intuitive.

### **NAS Synology : Stockage et Services Légers**
- **Container Registry** : Stockage centralisé pour les images Docker.
- **PostgreSQL avec pgvector** : Gestion de données sql classique et vectorielles pour des applications ML.
- **Synology Drive** : Synchronisation des fichiers comme alternative à Google Drive.
- **FTP et Rsync** : Gestion des transferts et sauvegardes de fichiers.

## Automatisation avec Ansible et Docker Compose

Pour orchestrer l'ensemble de cette infrastructure, j'utilise **Ansible** pour l’automatisation et **Docker Compose** pour le déploiement des services. Grâce à ces outils :
- Les configurations sont uniformisées et reproductibles.
- Les services peuvent être rapidement réinstallés en cas de problème.
- Les variables sensibles (mots de passe, clés API) sont gérées séparément dans des fichiers sécurisés.

## Page d’Accueil et Accessibilité

Tous les services sont accessibles depuis une page d’accueil centralisée, hébergée derrière le reverse proxy. Cette page liste tous les services avec des liens directs, des icônes et des descriptions, facilitant leur utilisation quotidienne.