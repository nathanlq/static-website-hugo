---
title: "Curriculum Vitae"
description: "CV de Nathan Leclercq — MLOps & Data Engineer"
showReadingTime: false
showDate: false
showAuthor: false
showTableOfContents: true
---

# Nathan Leclercq

[nathan.leclercq9@protonmail.com](mailto:nathan.leclercq9@protonmail.com) | [LinkedIn](https://www.linkedin.com/in/nathan-leclercq-51292014b/) | [GitHub](https://github.com/nathanlq) | [Blog](https://nathan.leclercq.spacesheep.ovh/) | [Télécharger en PDF](/pdf/cv_nathan_leclercq_fr.pdf)

---

## Profil

**MLOps & Data Engineer** chez DataKhi depuis 3 ans (alternance puis CDI). Je conçois et opère des plateformes data + ML de bout en bout : collecte, pipelines, modèles ML, déploiement, monitoring. Trois angles de travail récurrents : **souveraineté ciblée** (reprendre le contrôle des workloads sensibles sans tout migrer hors cloud existant), **frugalité infra** (mesurer plutôt que deviner la conso d'un cluster ML), **écoconception produit** (impact environnemental des systèmes ML, expérience Tossée + Ecobalyse). Master Machine Learning (Lille), formation initiale en mathématiques.

---

## Talks & Publications

- **DevLille 2026** (avril 2026, avec Jonathan Fritsch) — *"Reprenez le contrôle de votre plateforme data face aux géants américains"* : retour d'expérience sur le déploiement d'une plateforme data moderne en cloud privé (MinIO/Garage, PostgreSQL, DuckDB, K3s)
- **5 articles techniques publiés sur le [blog DataKhi](https://www.datakhi.fr/fr/blog)** (jan 2026) : plateforme data souveraine, stockage S3 self-hosted, migration vers open source, ML pour la prévision de demande, architectures de bases de données pour systèmes de recommandation
- **Articles techniques sur [mon blog perso](https://nathan.leclercq.spacesheep.ovh/posts/)** (2024-2026) : série Homelab (5 posts), série Book Reco (6 posts), retour Cloud Nord 2024, recherche harmonisation de mélodies

---

## Expérience Professionnelle

### DataKhi — Cabinet de conseil data, Tourcoing (2023 - présent)

**MLOps & Data Engineer — Mission Nyukom** · CDI · oct 2025 - présent
- Plateforme data télécom end-to-end : collecte (scraping 3CX, API Centreon), data lake objet, entrepôt PostgreSQL en schéma étoile, restitution Power BI
- Infrastructure complète déployée et opérée : K3s, Airflow, Ansible (5 rôles), registre OCI privé
- **Migration en cours du stockage objet MinIO vers Garage** (S3 européen) pour les workloads sensibles, mirror J-1 maintenu pendant la recette
- Multi-client avec partitionnement, idempotence, backfill historique
- Stack : Airflow 3, K3s, Ansible, Docker, PostgreSQL 17, MinIO, Garage, Playwright, Python

**MLOps Engineer — Mission drive-knowledge-mcp** · CDI · mai 2026 - présent
- Moteur de recherche sémantique sur un Drive d'entreprise SharePoint volumineux, exposé en serveur Model Context Protocol pour interrogation en langage naturel via Claude
- Architecture hybride pgvector + tsvector + trigram + RRF, embeddings Nomic Embed Text servis localement via Ollama, ingestion incrémentale via Microsoft Graph delta
- Angle souveraineté : aucun document envoyé à un LLM tiers, l'intelligence (embeddings + retrieval) reste chez le client
- Stack : Python, pgvector, Microsoft Graph, MSAL, Nomic Embed Text, MCP SDK, Azure AD

**Data Engineer — Pipeline ETL référentiel d'entreprises (SIRENE)** · CDI · 2025 - présent
- Pipeline d'alimentation PostgreSQL avec ~14,8M entreprises actives, ~23M établissements, enrichi des ratios financiers BCE/INPI (~6,3M lignes) et d'appels à l'API Annuaire des Entreprises
- Mode incrémental (UPSERT) ou full (swap atomique préservant les enrichissements API), tolérance aux erreurs, idempotence
- Schéma data warehouse `d_entreprise`, `d_etablissement`, `d_finance`, `d_dirigeant`
- Stack : Python, PyArrow, Parquet, Bulk INSEE, API Annuaire Entreprises

**Data + Platform Engineer — Benchmark S3 souverain (Garage vs MinIO)** · CDI · 2025 - 2026
- Conception et exécution d'un benchmark Garage vs MinIO (cluster 3 nœuds + mono-nœud) pour le choix du stockage objet sur workloads sensibles
- Mesures : lectures DuckDB sur dataset parquet multi-Go, écritures boto3, test de résilience (coupure de nœud + recovery)
- Automatisation Ansible reproductible, sert de socle technique au talk DevLille 2026
- Stack : Garage, MinIO, DuckDB, boto3, Ansible, Python

**Data Engineer — Infra data Hall U Need (Microsoft Fabric + Azure Data Factory)** · CDI (continuité alternance) · 2023 - présent
- Opération et évolution d'une infrastructure data hybride existante pour une moyenne entreprise du secteur de la restauration : Microsoft Fabric (data warehouse + notebooks), Azure Data Factory (orchestration de flux), pipelines de scraping custom Playwright pour les sources non-Azure
- Run quotidien : gestion des incidents en production, suivi des coûts cloud, monitoring des flux
- Enrichissement progressif au fil des demandes client : ajout de nouvelles sources (caisses, réservations, météo, RH, événementiel), nouveaux flux, optimisations coût et fiabilité, conteneurisation des pipelines custom
- Stack : Microsoft Fabric, Azure Data Factory, Azure SQL, Docker, Python, Playwright, Pandas

**ML Engineer — Prédiction d'affluence Hall U Need** · CDI (continuité alternance) · 2023 - présent
- Industrialisation d'un modèle de prédiction d'affluence restaurant (XGBoost quantile regression) sur la base de données alimentée par l'infra Fabric ci-dessus : 28 modèles indépendants, feature engineering avancé (météo, calendrier, jours fériés, ponts, événements, réservations J-X)
- Loss function custom Huber, calibration des intervalles de confiance, tests de non-régression (Pearson ≥ 0,999)
- Pipeline complet collecte Microsoft Fabric → entraînement → prédiction, workflow Makefile

**Data + MLOps Engineer — Mission Tossée** · Alternance · 2023 - 2025
- Écosystème data complet pour un agrégateur de mode éco-responsable (~15 sous-projets, archivé AGPL v3 publiquement)
- **Scoring d'impact environnemental** via API Ecobalyse, multi-marques (67 brands YAML), pipeline ML d'embedding produit pour la recherche sémantique
- Crawling et scraping à grande échelle (Scrapy + Playwright + FlareSolverr + moteur de règles YAML maison)
- Backend FastAPI + PostgreSQL/pgvector, app mobile Flutter (essayage virtuel DM-VTON, scan code-barres, OAuth multi-provider, géolocalisation), extension navigateur React/TypeScript
- Agent IA (OpenAI Agents SDK) pour extraction automatique de données depuis HTML
- Déploiement hybride on-premise / Azure (Functions, Blob)

**Développeur FullStack — Stage** · 2023 · 4 mois
- Système de versioning pour Power BI : backend C++ (différentiels de rapports), frontend React, distribution Electron

---

### Professeur de Musique · 2017 - présent
- Enseignement du saxophone (jazz, soul) et solfège — cours particuliers et écoles de musique

---

## Compétences Techniques

**MLOps & ML Engineering**
- Pipelines ML production end-to-end : training → serving → monitoring → reindex
- LLM serving local (Ollama, GPU partagé), embedding pipelines (Nomic Embed Text, sentence-transformers, CamemBERT)
- RAG en production : pgvector + tsvector + trigram + RRF, Model Context Protocol (MCP SDK)
- XGBoost (régression quantile), feature engineering, cross-validation temporelle, loss functions custom, calibration d'intervalles
- Observabilité LLM : Tempo OTLP, métriques custom Prometheus, alerting Grafana

**Data Engineering**
- Pipelines ETL end-to-end, schéma en étoile, partitionnement, idempotence, backfill
- Apache Airflow (DAGs, operators custom), Kestra (à l'essai), Microsoft Fabric, Azure Data Factory
- PostgreSQL avancé, PyArrow / Parquet, MinIO / Garage (stockage objet S3-compat), DuckDB
- Maintenance d'infra data hybride (run, coûts cloud, incidents, évolutions schéma)

**Infrastructure / DevOps / Frugalité**
- Kubernetes (K3s en production), Docker, Ansible (IaC, rôles, vault, sealed-secrets)
- Proxmox (cluster maison 4 nœuds), GPU sharing (nvidia-device-plugin time-slicing)
- Monitoring stack complète : Prometheus, Grafana, Loki, Tempo
- Mesure de conso : Kepler (eBPF + RAPL pour conso par pod), smart plugs / Home Assistant
- CI/CD : Forgejo Actions, Renovate self-hosted, registre OCI privé
- Azure (Fabric, Functions, Blob, DevOps)

**Web Scraping & Crawling**
- Playwright (headless), Scrapy, BeautifulSoup, FlareSolverr (anti-bot)
- Moteurs de règles YAML custom (DSL maison)

**Développement**
- Python (FastAPI, Pandas, scikit-learn, PyTorch), SQL, TypeScript (React), Dart (Flutter)
- Notions : Go, Rust, Haskell, C++, GraphQL

**Langages scientifiques / algo**
- Julia (compétitions : Google Hash Code, Reply Challenge, Cloudflight)
- R, NumPy / SciPy, Polars

---

## Projets Personnels

**Plateforme MLOps Homelab** · 2024 - présent
- Cluster Proxmox + K3s (4 nœuds, dont un GPU RTX 4060 Ti) opéré entièrement via Ansible
- Services en production : Ollama (qwen3:14b), Forgejo + Actions, Vaultwarden, Miniflux, Renovate, knowledge-mcp, monitoring Prom/Grafana/Loki/Tempo
- Gestion d'énergie : WoL + shutdown nocturne automatisé, scale-to-zero on-demand, KEEP_ALIVE GPU
- [Articles techniques publiés](https://nathan.leclercq.spacesheep.ovh/posts/)

**knowledge-mcp — RAG personnel exposé en MCP** · 2026 - présent
- Moteur de RAG sémantique perso sur ~35k chunks de documents (markdown, code, articles), exposé en serveur Model Context Protocol pour Claude / Cursor
- Architecture identique à drive-knowledge-mcp (côté Datakhi) : pgvector + tsvector + trigram + RRF, Nomic Embed via Ollama
- Déployé en production sur le homelab : Deployment HTTP (CPU, ~50ms par requête), CronJob de reindex GPU
- Stack : Python, pgvector, Nomic Embed, Ollama, MCP SDK, K3s, Forgejo Actions

**Système de Recommandation de Livres** · 2023 - 2025
- Pipeline data complet : scraping d'un large catalogue, embeddings (TF-IDF + CamemBERT), API FastAPI, PostgreSQL/pgvector, MLflow, interface Vue.js
- [Articles techniques publiés](https://nathan.leclercq.spacesheep.ovh/posts/)

**Club Algorithmie** · 2020 - 2024
- Préparation et participation aux compétitions de programmation
- Solutions optimisées en Julia · Google Hash Code, Reply Challenge, Cloudflight

**Recherche : Harmonisation de Mélodies** · 2024
- Étude comparative de modèles et algorithmes pour l'harmonisation musicale automatique

---

## Formation

**Master Machine Learning** · Université de Lille · 2023 - 2025
- Deep Learning, NLP, MLOps · Déploiement de LLMs sur infrastructure GPU

**Licence Informatique** · Université de Lille · 2020 - 2023
- Algorithmique avancée, architecture distribuée, développement fullstack

**Cursus Mathématiques** (L1-L3) · Université de Lille · 2017 - 2020
- Analyse numérique, probabilités/statistiques, algèbre linéaire appliquée

---

## Langues

- Français : natif
- Anglais : professionnel (TOEIC 885)

---

## Centres d'intérêt

- Musique : saxophone jazz/soul, orchestre
- Sport : vélo quotidien, badminton
- Lecture : science-fiction, essais techniques (sobriété numérique, AI Act, design système)
- Jeux de rôle sur table
