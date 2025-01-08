---
title: "Book Reco : Déploiement et Orchestration"
date: 2025-01-05
draft: false
tags: ["docker", "deployment", "automation", "homelab", "makefile", "containerization"]
---

Pour finaliser mon projet de recommandation de livres, j'ai mis en place une stratégie de déploiement basée sur Docker et orchestrée via un Makefile. L'ensemble du système est hébergé dans mon homelab, avec une API accessible à l'adresse https://app.bookfarm.spacesheep.ovh/. Tout est sur le dépôt [Github](https://github.com/nathanlq/book-reco).

## Architecture de Déploiement

Le déploiement s'articule autour de trois composants principaux :

1. **Pipeline de données** : Gère la collecte et le traitement des données
2. **Microservices** : Services de vectorisation, clustering et gestion des images
3. **API** : Point d'entrée pour les requêtes clients

Chaque composant est conteneurisé avec Docker et peut être déployé indépendamment grâce à un Makefile qui orchestre l'ensemble.

## Structure Docker

Le projet utilise trois Dockerfiles distincts pour gérer les différents aspects du système :

```bash
.
├── Dockerfile.api           # Configuration pour l'API
├── Dockerfile.microservices # Configuration pour les microservices
├── Dockerfile.pipeline      # Configuration pour le pipeline de données
├── docker-compose-microservices.yml
└── docker-compose-pipeline.yml
```

### Pipeline de Données (Dockerfile.pipeline)

Le pipeline est construit sur une image Python 3.11-slim et inclut les outils nécessaires pour le scraping et le traitement des données :

```dockerfile
FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements-data-loader.txt .
RUN pip install --no-cache-dir -r requirements-data-loader.txt
RUN pip install scrapy==2.11.2
```

Le script d'entrée gère automatiquement :
- Le rafraîchissement optionnel des données via Scrapy
- La compression et la préparation des données
- Le chargement en base de données

### Microservices (Dockerfile.microservices)

Les microservices partagent une configuration commune mais sont différenciés par une variable d'environnement `SERVICE_NAME` :

```yaml
services:
  clustering-service:
    env_file: ./.env
    environment:
      - SERVICE_NAME=clustering
    volumes:
      - ./data:/app/data

  vectorizer-service:
    env_file: ./.env
    environment:
      - SERVICE_NAME=vectorizer

  images-service:
    env_file: ./.env
    environment:
      - SERVICE_NAME=images
```

### API (Dockerfile.api)

L'API est déployée avec un serveur Uvicorn et exposée sur le port 8000. Je la redirige ensuite vers un port moins usité (en l'occurence le 9999) dans le fichier `docker-compose-microservices.yml`.

```dockerfile
FROM python:3.11-slim

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "expose.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Orchestration avec Makefile

Le Makefile sert de point d'entrée unifié pour gérer le déploiement. Il propose plusieurs commandes :

```makefile
pipeline:                 # Lance le pipeline de données
pipeline-with-scraping:   # Lance le pipeline avec rafraîchissement des données
api:                     # Démarre uniquement l'API
microservices:           # Démarre les microservices
stop-services:           # Arrête tous les services
clean:                   # Nettoie les ressources Docker
```

Cette approche permet une grande flexibilité :
- Déploiement complet : `make pipeline && make microservices && make api`
- Mise à jour des données : `make pipeline-with-scraping`
- Redémarrage des services : `make stop-services && make microservices`

## Sécurité et Accès

L'API est accessible via HTTPS à l'adresse https://app.bookfarm.spacesheep.ovh/ et protégée par une authentification HTTP basique. Cette approche simple mais efficace convient parfaitement à un projet hébergé en homelab.

La base de données PostgreSQL et le serveur MLFlow est hébergée localement dans mon homelab et exposé derrière mon proxy, ce qui garantit :
- Un contrôle total sur les données
- Des temps de latence minimaux

Après tout ce développement, j'ai une api exploitable, avec ce swagger :

![images](/swagger.png)

## Monitoring et Maintenance

Le système est conçu pour être facilement maintenu :
1. Les logs Docker permettent de suivre l'état des services
2. Le Makefile facilite les opérations courantes
3. Les volumes Docker persistent les données importantes

## Conclusion

Cette architecture de déploiement offre un bon équilibre entre simplicité et efficacité. Le système est :
- Facilement déployable grâce aux commandes Make
- Modulaire grâce à la containerisation
- Sécurisé tout en restant accessible
- Simple à maintenir et à mettre à jour

Les dernières chose que je pourrais faire pour avoir un livrable serait de produire le playbook ansible de déploiement (vu qu'il s'agit d'un POC et que le déploiement avec le Makefile et git est très rapide et reproductible, je vais m'en passer), un finetuning du modèle de génération d'embedding sur les labels récoltés initialement dans ma données (je manque de temps et de puissance de calcul pour le moment) et d'un petit front pour illustrer l'api d'un autre manière qu'à travers son swagger.