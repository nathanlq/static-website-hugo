---
title: "Projets"
description: "Missions professionnelles et projets personnels."
showDate: false
showReadingTime: false
showAuthor: false
showTableOfContents: true
---

## Missions professionnelles — DataKhi

### Nyukom — Plateforme data télécom
*Data Engineer · oct 2025 - présent*

Plateforme data end-to-end pour un opérateur télécom : collecte de données 3CX (scraping) et métriques Centreon (API), data lake objet, entrepôt PostgreSQL en schéma étoile, restitution Power BI. Infrastructure déployée sur K3s avec Airflow, Ansible et registre Docker privé. Multi-client, partitionnement, idempotence, backfill historique. **Migration en cours du stockage objet MinIO vers Garage (S3 européen) pour les workloads sensibles**, MinIO conservé en mirror J-1 pendant la phase de recette.

`Airflow` `K3s` `Ansible` `PostgreSQL` `MinIO` `Garage` `Docker` `Playwright` `Python`

Articles liés sur le blog DataKhi :
- [Construire une plateforme de données souveraine](https://www.datakhi.fr/fr/blog/plateforme-donnees-souveraine-architecture)
- [Stockage de fichiers auto-hébergé : stockage objet et alternatives](https://www.datakhi.fr/fr/blog/garage-stockage-s3-europeen-alternative-minio)
- [Passer à l'open source : comment ça se passe concrètement](https://www.datakhi.fr/fr/blog/integration-infrastructure-open-source-guide-pratique)

---

### drive-knowledge-mcp — RAG sur Drive d'entreprise via MCP
*MLOps Engineer · mai 2026 - présent*

Moteur de recherche sémantique sur un SharePoint d'entreprise (plusieurs centaines de Go), exposé en serveur Model Context Protocol pour être interrogé en langage naturel via Claude. Pattern jumeau du projet perso `knowledge-mcp`, mais source = SharePoint via Microsoft Graph (ingestion incrémentale via API delta) au lieu d'un walker filesystem. V0 = métadonnées + descriptors enrichis embedés via Nomic Embed Text (local), recherche hybride pgvector + tsvector + trigram + RRF. Permet d'interroger le Drive sans télécharger ni envoyer les fichiers à un LLM tiers — l'intelligence (embeddings) reste chez Datakhi.

`Python` `pgvector` `Microsoft Graph` `MSAL` `Nomic Embed Text` `MCP SDK` `Azure AD (Entra ID)`

---

### Pipeline ETL référentiel d'entreprises (SIRENE)
*Data Engineer · 2025 - présent*

Pipeline ETL alimentant une base PostgreSQL avec les données du répertoire SIRENE (~14,8M entreprises actives, ~23M établissements), enrichi des ratios financiers BCE/INPI (~6,3M lignes) et d'un appel à l'API Annuaire des Entreprises (géolocalisation, dirigeants, flags Qualiopi/RGE/BIO). Mode incrémental (UPSERT) ou full (swap atomique préservant les enrichissements API). Tolérance aux erreurs, idempotence, partitions par activité économique. Schéma data warehouse `d_entreprise`, `d_etablissement`, `d_finance`, `d_dirigeant`. Sert de base à la prospection chez Datakhi.

`PostgreSQL` `Python` `Parquet` `Bulk INSEE` `API Annuaire Entreprises` `pandas`

---

### Benchmark S3 souverain — Garage vs MinIO
*Data + Platform Engineer · 2025 - 2026*

Benchmark comparatif Garage et MinIO (cluster 3 nœuds vs mono-nœud), pour décider du stockage objet à utiliser sur les workloads sensibles d'entreprise. Mesures : 10 lectures DuckDB sur un dataset parquet de plusieurs Go + 4 écritures boto3, plus un test de résilience (coupure d'un nœud, vérification de la recovery). Mode dry-run pour calibrer, automatisation Ansible pour reproduire sur n'importe quel cluster. Sert de socle au talk DevLille 2026.

`Garage` `MinIO` `DuckDB` `boto3` `Ansible` `Python` `S3`

---

### Hall U Need — Infrastructure data Microsoft Fabric + Azure Data Factory
*Data Engineer · 2023 - présent*

Opération, maintenance et évolution d'une infrastructure data existante pour une moyenne entreprise du secteur de la restauration. Stack hybride Microsoft Fabric + Azure Data Factory pour l'orchestration et le data warehouse, complétée par des pipelines de scraping custom et de l'intégration métier (sources hétérogènes : caisses, réservations, météo, RH, événementiel). Run quotidien des pipelines, gestion des incidents en production, suivi des coûts cloud, et enrichissement progressif au fil des demandes du client : ajout de nouvelles sources, nouveaux flux, optimisations de coût et de fiabilité.

`Microsoft Fabric` `Azure Data Factory` `Azure SQL` `Docker` `Python` `Playwright` `Pandas`

---

### Hall U Need — Prédiction d'affluence restaurant
*ML Engineer · 2023 - présent*

Modèle de prédiction d'affluence par XGBoost quantile regression sur la même base de données alimentée par l'infra Microsoft Fabric (ci-dessus). 28 modèles indépendants (2 variantes × 2 périodes × 7 jours), feature engineering avancé (lags, rolling stats, météo, calendrier, jours fériés, ponts, événements, réservations J-X, encoding cyclique). Loss function custom Huber, calibration d'intervalles de confiance, tests de non-régression (Pearson ≥ 0,999). Pipeline complet : collecte Microsoft Fabric → entraînement → prédiction, workflow Makefile.

`XGBoost` `Python` `Pandas` `scikit-learn` `Microsoft Fabric` `Makefile`

Articles liés sur le blog DataKhi :
- [Anticiper l'affluence grâce au machine learning](https://www.datakhi.fr/fr/blog/prevision-demande-machine-learning-restauration)

---

### Tossée — Agrégateur de mode éco-responsable
*Data Engineer & ML Engineer · 2023 - 2025 (alternance)*

Écosystème data complet : scraping multi-marques (moteur de règles YAML custom), normalisation, calcul d'impacts environnementaux via Ecobalyse, embeddings produit, API backend avec recherche sémantique, app mobile Flutter avec essayage virtuel (DM-VTON), extension navigateur React/TypeScript, agent IA pour extraction de données.

`FastAPI` `PostgreSQL` `pgvector` `Playwright` `Scrapy` `Flutter` `React` `TypeScript` `Azure` `OpenAI Agents SDK` `Ansible`

Articles liés sur le blog DataKhi :
- [Systèmes de recommandation : quelle architecture de BDD choisir](https://www.datakhi.fr/fr/blog/systemes-recommandation-architecture-base-donnees-2025)

---

## Projets personnels

### Plateforme MLOps Homelab
*2024 - présent*

Infrastructure auto-hébergée pour le MLOps frugal et souverain. Cluster Proxmox + K3s (4 nodes, dont un GPU RTX 4060 Ti pour le serving LLM/embedding), CloudNative-PG avec pgvector, observabilité Prometheus/Grafana/Loki, Ollama pour les modèles locaux, déploiement IaC via Ansible, registre OCI Forgejo, scheduling énergétique nocturne (WoL + drain k8s automatisé). Une vraie plateforme MLOps en miniature : du provisionnement au serving de modèles, avec un focus sobriété (mesure conso via Kepler + smart plug).

`Proxmox` `K3s` `Ansible` `CloudNative-PG` `pgvector` `Ollama` `Forgejo` `Prometheus` `Grafana` `Loki` `Sealed-secrets`

[Lire la série d'articles Homelab →](/posts/homelab0/)

---

### knowledge-mcp — RAG personnel exposé en MCP
*2026 - présent*

Moteur de RAG sémantique perso sur ~35k chunks de documents (markdown, code, articles), exposé en serveur Model Context Protocol pour être consommé par Claude / Cursor / autres clients. Architecture hybride pgvector + tsvector + trigram + RRF, reranking, embeddings Nomic Embed Text v2 (768d) servis localement via Ollama sur GPU. Déployé en production sur le homelab : Deployment HTTP côté CPU (requêtes ~50ms), CronJob de reindex côté GPU (5min vs >2h sans GPU). Authentification Bearer token, ingress Traefik derrière NPM.

`Python` `pgvector` `Nomic Embed Text` `Ollama` `MCP SDK` `K3s` `Forgejo Actions`

---

### Système de recommandation de livres
*2023 - 2025*

Pipeline data complet pour la recommandation de livres : scraping d'un large catalogue de livres, transformation et stockage en base vectorielle, génération d'embeddings (TF-IDF + CamemBERT), API FastAPI avec recherche par similarité, interface Vue.js. Tracking d'expérimentations avec MLflow.

`Scrapy` `FastAPI` `PostgreSQL` `pgvector` `CamemBERT` `MLflow` `Vue.js` `Docker`

[Lire la série d'articles Book Reco →](/posts/bookrecopart0/)

---

### Recherche : Harmonisation de mélodies
*2024*

Étude comparative de modèles, algorithmes et logiciels pour l'harmonisation automatique de mélodies. Croisement entre passion musicale et compétences techniques — revue de 5 articles de recherche couvrant des approches probabilistes, HMM et algorithmes génétiques.

`Recherche` `Musique` `Algorithmes`

[Lire l'article →](/posts/melodyharmony/)

---

### Club algorithmie et compétitions
*2020 - 2024*

Préparation et participation aux compétitions de programmation pendant les années fac : Google Hash Code, Reply Code Challenge, Cloudflight. Solutions d'optimisation en Julia.

`Julia` `Algorithmes` `Optimisation`
