---
title: "Curriculum Vitae"
description: "CV de Nathan Leclercq — Data Engineer & ML Engineer"
showReadingTime: false
showDate: false
showAuthor: false
showTableOfContents: true
---

# Nathan Leclercq

nathan.leclercq9@protonmail.com | [LinkedIn](https://www.linkedin.com/in/nathan-leclercq-51292014b/) | [GitHub](https://github.com/nathanlq) | [Blog](https://nathan.leclercq.spacesheep.ovh/) | [Télécharger en PDF](/pdf/cv_nathan_leclercq_fr.pdf)

---

## Profil

Data Engineer et ML Engineer chez DataKhi depuis 3 ans (alternance puis CDI). Je conçois et opère des plateformes data de bout en bout : collecte, pipelines, modèles ML, déploiement, monitoring. Formation en mathématiques et informatique, Master Machine Learning (Lille). Je ne fais pas que du code — je déploie, j'industrialise et je livre.

---

## Expérience Professionnelle

### DataKhi — Cabinet de conseil data, Tourcoing (2023 - présent)

**Data Engineer — Mission Nyukom** · CDI · oct 2025 - présent
- Conception et déploiement d'une plateforme data télécom end-to-end : collecte (scraping 3CX, API Centreon), data lake MinIO, entrepôt PostgreSQL en schéma étoile, restitution Power BI
- Déploiement de l'infrastructure complète : K3s, Airflow, Ansible (5 rôles), registre Docker privé
- Gestion multi-client avec partitionnement, idempotence et backfill historique
- ~22 000 lignes de code · Stack : Airflow, K3s, Ansible, Docker, PostgreSQL, MinIO, Playwright, Pandas

**ML Engineer — Mission Hall U Need** · CDI (continuité alternance) · 2023 - présent
- Industrialisation d'un modèle de prédiction d'affluence restaurant (XGBoost quantile regression)
- 28 modèles indépendants, feature engineering avancé (50+ features : météo, calendrier, jours fériés, réservations J-minus, encoding cyclique)
- Loss function custom (Huber), calibration des intervalles de confiance, tests de non-régression (Pearson ≥ 0.999)
- Pipeline complet : collecte Microsoft Fabric → entraînement → prédiction · Workflow Makefile

**Data Engineer & ML Engineer — Mission Tossée** · Alternance · 2023 - 2025
- Architecture d'un écosystème data complet pour un agrégateur de mode éco-responsable (~15 sous-projets)
- Scraping multi-marques (Playwright, Scrapy, moteur de règles YAML custom, 20+ marques)
- Pipeline de normalisation, calcul d'impacts environnementaux (API Ecobalyse), embeddings produit
- API backend (FastAPI, PostgreSQL/pgvector, recherche sémantique, recommandation) — temps de réponse < 100ms
- App mobile Flutter : essayage virtuel (DM-VTON), scan code-barres, OAuth multi-provider, géolocalisation
- Extension navigateur React/TypeScript pour affichage des impacts en temps réel
- Agent IA (OpenAI Agents SDK) pour extraction automatique de données depuis HTML
- Déploiement hybride on-premise / Azure (Functions, Blob, DevOps)

**Développeur FullStack — Stage** · 2023 · 4 mois
- Système de versioning pour PowerBI : backend C++ (différentiels de rapports), frontend React, distribution Electron

---

### Professeur de Musique · 2017 - présent
- Enseignement du saxophone (jazz, soul) et solfège — cours particuliers et écoles de musique

---

## Compétences Techniques

**Data Engineering**
- Pipelines ETL end-to-end, schéma en étoile, partitionnement, idempotence, backfill
- Apache Airflow · PostgreSQL · MinIO (S3) · Parquet / PyArrow · Microsoft Fabric

**Machine Learning**
- XGBoost (régression quantile) · Feature engineering · Cross-validation temporelle
- Embeddings / recherche vectorielle (pgvector) · CamemBERT / Transformers · MLflow
- Calibration d'intervalles de confiance · Loss functions custom

**DevOps / Infrastructure**
- Kubernetes (K3s) · Docker · Ansible (IaC, rôles, vault) · Proxmox
- Monitoring : Prometheus / Grafana · CI/CD : Makefile, pipelines
- Azure (Fabric, Functions, Blob, DevOps)

**Développement**
- Python (FastAPI, Pandas, scikit-learn) · SQL · TypeScript (React) · Dart (Flutter)
- Scraping : Playwright, Scrapy, BeautifulSoup
- Notions : Go, Rust, Haskell, C++

**Langages scientifiques / algo**
- Julia (compétitions : Google Hash Code, Reply Challenge, Cloudflight) · R · NumPy / SciPy

---

## Projets Personnels

**Plateforme MLOps Homelab** · 2024 - présent
- Infrastructure auto-hébergée : Proxmox, serveurs GPU, services ML, agents crewAI avec RAG
- Monitoring Prometheus/Grafana, déploiement Ansible, registre Docker, Gitea
- [5 articles techniques publiés](https://nathan.leclercq.spacesheep.ovh/posts/)

**Système de Recommandation de Livres** · 2023 - 2025
- Pipeline data complet : scraping >100k livres, embeddings (TF-IDF + CamemBERT), API FastAPI
- PostgreSQL/pgvector, MLflow, interface Vue.js
- [6 articles techniques publiés](https://nathan.leclercq.spacesheep.ovh/posts/)

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
- Lecture : science-fiction, essais techniques
- Jeux de rôle sur table

---

## Publications

- [5 articles techniques sur le blog DataKhi](https://www.datakhi.fr/fr/blog) (2026)
- [14 articles techniques sur mon blog personnel](https://nathan.leclercq.spacesheep.ovh/posts/) (2024-2025)
