---
title: "Projets"
date: "2026-02-13"
draft: false
---

## Missions professionnelles — DataKhi

### Nyukom — Plateforme data télécom
*Data Engineer · oct 2025 - présent*

Plateforme data end-to-end pour un opérateur télécom : collecte de données 3CX (scraping) et métriques Centreon (API), data lake MinIO, entrepôt PostgreSQL en schéma étoile, restitution Power BI. Infrastructure déployée sur K3s avec Airflow, Ansible et registre Docker privé. Multi-client, partitionnement, idempotence, backfill historique.

`Airflow` `K3s` `Ansible` `PostgreSQL` `MinIO` `Docker` `Playwright` `Python`

Articles liés sur le blog DataKhi :
- [Construire une plateforme de données souveraine](https://www.datakhi.fr/fr/blog)
- [Stockage de fichiers auto-hébergé : stockage objet et alternatives](https://www.datakhi.fr/fr/blog)
- [Passer à l'open source : comment ça se passe concrètement](https://www.datakhi.fr/fr/blog)

---

### Hall U Need — Prédiction d'affluence restaurant
*ML Engineer · 2023 - présent*

Modèle de prédiction d'affluence par XGBoost quantile regression. 28 modèles indépendants avec feature engineering avancé (50+ features : météo, calendrier, jours fériés, réservations J-minus). Loss function custom Huber, calibration d'intervalles de confiance, tests de non-régression. Pipeline complet de la collecte Microsoft Fabric à la prédiction.

`XGBoost` `Python` `Pandas` `scikit-learn` `Microsoft Fabric` `Makefile`

Articles liés sur le blog DataKhi :
- [Anticiper l'affluence grâce au machine learning](https://www.datakhi.fr/fr/blog)

---

### Tossée — Agrégateur de mode éco-responsable
*Data Engineer & ML Engineer · 2023 - 2025 (alternance)*

Écosystème complet (~15 sous-projets) : scraping multi-marques (20+ marques, moteur de règles YAML custom), normalisation, calcul d'impacts environnementaux via Ecobalyse, embeddings produit, API backend avec recherche sémantique, app mobile Flutter avec essayage virtuel (DM-VTON), extension navigateur React/TypeScript, agent IA pour extraction de données.

`FastAPI` `PostgreSQL` `pgvector` `Playwright` `Scrapy` `Flutter` `React` `TypeScript` `Azure` `OpenAI Agents SDK` `Ansible`

Articles liés sur le blog DataKhi :
- [Systèmes de recommandation : quelle architecture de BDD choisir](https://www.datakhi.fr/fr/blog)

---

## Projets personnels

### Plateforme MLOps Homelab
*2024 - présent*

Infrastructure auto-hébergée pour le machine learning et l'expérimentation technique. Proxmox (hyperviseur), serveurs GPU, services ML (agents crewAI avec RAG), monitoring Prometheus/Grafana, déploiement automatisé Ansible, registre Docker privé, Gitea.

`Proxmox` `Docker` `Ansible` `Prometheus` `Grafana` `PostgreSQL` `pgvector` `MLflow`

[Lire la série d'articles Homelab →](/posts/homelab0)

---

### Système de recommandation de livres
*2023 - 2025*

Pipeline data complet pour la recommandation de livres : scraping de >100k livres, transformation et stockage en base vectorielle, génération d'embeddings (TF-IDF + CamemBERT), API FastAPI avec recherche par similarité, interface Vue.js. Tracking d'expérimentations avec MLflow.

`Scrapy` `FastAPI` `PostgreSQL` `pgvector` `CamemBERT` `MLflow` `Vue.js` `Docker`

[Lire la série d'articles Book Reco →](/posts/bookrecopart0)

---

### Recherche : Harmonisation de mélodies
*2024*

Étude comparative de modèles, algorithmes et logiciels pour l'harmonisation automatique de mélodies. Croisement entre passion musicale et compétences techniques — revue de 5 articles de recherche couvrant des approches probabilistes, HMM et algorithmes génétiques.

`Recherche` `Musique` `Algorithmes`

[Lire l'article →](/posts/melodyharmony)

---

### Club algorithmie et compétitions
*2020 - 2024*

Préparation et participation aux compétitions de programmation pendant les années fac : Google Hash Code, Reply Code Challenge, Cloudflight. Solutions d'optimisation en Julia.

`Julia` `Algorithmes` `Optimisation`
