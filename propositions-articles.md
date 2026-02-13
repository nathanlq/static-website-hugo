# Propositions d'articles — Catalogue complet

Légende carrière :
- **A** = Data Engineer (pipelines, orchestration, warehouse)
- **B** = ML Engineer / MLOps (industrialisation ML, serving, monitoring)
- **C** = Fullstack Data / Lead Tech / CTO (produit, polyvalence, architecture)
- **D** = Platform Engineer / SRE (infra, observabilité, sécurité)

---

## 1. Renvoi vers le blog DataKhi

**Concept** : Un post court (pas un article technique) qui présente tes 5 articles publiés sur le blog DataKhi, avec le contexte personnel de chacun (pourquoi tu l'as écrit, sur quelle mission). Pas de paraphrase, juste le renvoi.

**Ce que ça implique de ta part** : Rien. Juste valider le texte.

**Carrière** : Transversal. Montre que tu publies en contexte pro. Signal de crédibilité pour tout recruteur.

---

## 2. Observabilité d'un pipeline data : OpenTelemetry, logs structurés et alerting

**Concept** : Prendre un de tes pipelines existants (Nyukom ou Book Reco) et ajouter une couche d'observabilité complète : logs structurés (structlog), traces OpenTelemetry, métriques custom Prometheus, alerting (Alertmanager ou Grafana alerts). Documenter le avant/après.

**Ce que ça implique de ta part** : Projet homelab. Installer OpenTelemetry collector sur ton K3s, instrumenter un pipeline Python existant, configurer des dashboards Grafana et des règles d'alerte. ~1-2 weekends de travail.

**Carrière** : **B+D**. Comble ta lacune la plus visible (observabilité). Les offres ML Engineer et Platform Engineer demandent systématiquement cette compétence.

---

## 3. Tests automatisés pour pipelines data : pytest, Great Expectations, tests de contrat

**Concept** : Ajouter une suite de tests complète à un pipeline existant. Tests unitaires (pytest), tests de qualité de données (Great Expectations ou Soda), tests d'intégration, tests de non-régression. Montrer le setup, les patterns, et ce que ça change dans la confiance qu'on a dans le pipeline.

**Ce que ça implique de ta part** : Prendre un projet existant (Book Reco est idéal car public) et ajouter les tests. ~1-2 weekends.

**Carrière** : **A+B**. Comble ta lacune "pas de tests dans les projets". Signal de maturité ingénieur, très regardé par les boîtes sérieuses.

---

## 4. Entraîner un modèle deep learning from scratch sur un homelab GPU

**Concept** : Un projet NLP ou vision modeste mais entraîné from scratch avec PyTorch sur ton serveur GPU. Pas un fine-tuning de modèle pré-entraîné — un entraînement complet avec dataset, architecture, training loop, évaluation. Documenter les choix, les galères GPU (CUDA, mémoire), les résultats.

**Ce que ça implique de ta part** : Choisir un problème (classification de texte, détection d'objet, génération...), collecter ou trouver un dataset, coder le training loop PyTorch, itérer. ~3-5 weekends. C'est le plus gros investissement de la liste.

**Carrière** : **B fort**. Comble ta lacune "PyTorch en dépendance mais pas en code natif". Ouvre les portes des offres ML Engineer qui demandent du deep learning.

---

## 5. Construire un feature store artisanal avec PostgreSQL et Redis

**Concept** : Implémenter un feature store minimaliste sur ton homelab. Stockage des features dans PostgreSQL (offline store) et Redis (online store pour le serving temps réel). Point d'entrée unique pour le feature engineering, versionning des features, backfill. Comparer avec Feast/Tecton pour montrer ce qu'on gagne et ce qu'on perd.

**Ce que ça implique de ta part** : Projet homelab. Coder le feature store en Python, l'intégrer avec un pipeline existant (HUN ou Book Reco). ~2-3 weekends.

**Carrière** : **B**. Les feature stores sont un sujet MLOps avancé. Peu de juniors en ont construit un. Différenciant.

---

## 6. Servir un modèle ML en production : comparatif BentoML, FastAPI, Seldon

**Concept** : Prendre un modèle existant (le XGBoost HUN par exemple) et le servir de 3 manières différentes. Comparer les performances (latence, throughput), la facilité de déploiement sur K3s, le monitoring, le versionning. Lequel choisir et quand.

**Ce que ça implique de ta part** : Projet homelab. Déployer les 3 solutions sur ton K3s, benchmarker. ~2 weekends.

**Carrière** : **B**. Model serving est un skill MLOps core. L'approche comparative montre du recul.

---

## 7. Data drift et monitoring de modèles ML en production

**Concept** : Mettre en place un système de détection de data drift et concept drift sur un modèle en production. Utiliser Evidently ou Whylabs, intégrer avec Prometheus/Grafana pour les alertes. Montrer un cas concret : quand les données changent (météo exceptionnelle, changement de comportement client), le modèle se dégrade-t-il ?

**Ce que ça implique de ta part** : Projet homelab. Simuler ou utiliser des vraies dérives sur les données HUN. ~2 weekends.

**Carrière** : **B fort**. Le monitoring de modèles est le sujet MLOps le plus demandé et le moins maîtrisé par les juniors.

---

## 8. GitOps sur K3s : ArgoCD pour déployer des pipelines data

**Concept** : Remplacer ou compléter tes déploiements Ansible par du GitOps avec ArgoCD. Un push sur le repo = un déploiement automatique sur K3s. Montrer le setup, la gestion des secrets, le rollback, et comment ça s'intègre avec un workflow data (DAGs Airflow, images Docker).

**Ce que ça implique de ta part** : Projet homelab. Installer ArgoCD sur ton K3s, migrer un ou deux déploiements. ~1-2 weekends.

**Carrière** : **D+A**. GitOps est standard dans le monde platform/SRE. Complète ton profil infra.

---

## 9. Construire un système RAG complet sur un homelab

**Concept** : Un pipeline Retrieval-Augmented Generation de bout en bout sur ton infra. Ingestion de documents (PDF, Markdown), chunking, embeddings (modèle open source type e5 ou bge), stockage dans pgvector, API de requêtage avec un LLM local (Ollama/vLLM) ou distant. Pas un tuto LangChain — une implémentation maison qui montre les choix d'architecture.

**Ce que ça implique de ta part** : Projet homelab. Tu as déjà pgvector et un serveur GPU. Coder le pipeline d'ingestion, le retriever, et l'interface de requêtage. ~2-3 weekends.

**Carrière** : **B+C**. RAG est le use case LLM le plus demandé en entreprise. Montre que tu sais construire un produit IA complet.

---

## 10. Déployer Airflow sur K3s : retour d'expérience et pièges

**Concept** : Un article pratico-pratique sur le déploiement d'Airflow en production sur K3s. Les choix (Helm vs manifestes custom, CeleryExecutor vs KubernetesExecutor), la gestion des ressources, la synchronisation des DAGs, les problèmes réseau inter-namespaces, le monitoring. Pas un tuto — un retour d'expérience honnête.

**Ce que ça implique de ta part** : Rien de nouveau si tu documentes ce que tu as déjà fait sur Nyukom. Juste rédiger.

**Carrière** : **A+D**. Airflow + K3s est un combo très demandé. L'article montre que tu opères de l'infra data pour de vrai.

---

## 11. Comparer les orchestrateurs data : Airflow vs Dagster vs Prefect

**Concept** : Déployer les 3 sur ton homelab, faire tourner le même pipeline sur chacun, comparer l'expérience développeur, les performances, la facilité de déploiement sur K3s, la communauté. Tu connais Airflow — découvrir les alternatives et avoir un avis argumenté.

**Ce que ça implique de ta part** : Installer Dagster et Prefect, porter un pipeline simple. ~2-3 weekends.

**Carrière** : **A**. Montre de la culture technique et du recul. Les seniors comparent, les juniors utilisent ce qu'on leur dit.

---

## 12. Lakehouse maison : MinIO + DuckDB (ou Spark) sur un homelab

**Concept** : Construire une architecture lakehouse sur ton infra. MinIO comme stockage (tu l'as déjà), DuckDB ou Spark pour le traitement, format Parquet/Iceberg. Montrer que le pattern lakehouse n'est pas réservé à Databricks — on peut le faire sur du matériel qu'on possède.

**Ce que ça implique de ta part** : Projet homelab. Installer DuckDB ou Spark, configurer la lecture depuis MinIO, écrire quelques transformations. ~1-2 weekends.

**Carrière** : **A fort**. Le lakehouse et les formats de table ouverts (Iceberg, Delta) sont le sujet data engineering de 2025-2026. Comble ton manque de Spark/Databricks.

---

## 13. Streaming data : Redpanda (ou Kafka) sur un homelab

**Concept** : Ajouter une couche streaming à ton infra. Installer Redpanda (Kafka-compatible, plus léger), construire un pipeline qui ingère des événements en temps réel, les transforme, et les charge en base. Cas d'usage : ingestion de logs, métriques temps réel, ou CDC (Change Data Capture).

**Ce que ça implique de ta part** : Projet homelab. Installer Redpanda sur K3s, écrire un producer/consumer, intégrer avec PostgreSQL. ~2 weekends.

**Carrière** : **A**. Le streaming est un trou dans ton profil (tout est batch actuellement). Les offres Data Engineer mid/senior demandent souvent Kafka.

---

## 14. App mobile + ML embarqué : retour d'expérience Flutter et Virtual Try-On

**Concept** : Documenter le développement de l'app mobile Tossée — le virtual try-on (DM-VTON via Replicate/HuggingFace), le scan de code-barres, l'OAuth multi-provider, la géolocalisation. Un data engineer qui fait du mobile avec du ML vision, c'est atypique. Montrer le processus, les galères, les compromis (API distante vs ML embarqué).

**Ce que ça implique de ta part** : Rien de nouveau — juste documenter ce que tu as déjà fait.

**Carrière** : **C**. Signal de polyvalence extrême. Idéal pour le positionnement "je peux construire un produit seul".

---

## 15. Terraform pour un homelab : infrastructure as code au-delà d'Ansible

**Concept** : Compléter Ansible (qui gère la configuration) avec Terraform (qui gère le provisionnement). Provisionner les VMs Proxmox, les namespaces K3s, les buckets MinIO, les bases PostgreSQL avec Terraform. Montrer la complémentarité Terraform + Ansible.

**Ce que ça implique de ta part** : Projet homelab. Apprendre Terraform (si pas déjà fait), écrire les modules pour ton infra. ~2-3 weekends.

**Carrière** : **D+A**. Terraform est le trou le plus visible de ton profil infra. Quasi-obligatoire pour les offres Platform Engineer et demandé en Data Engineer senior.

---

## 16. CI/CD complète avec Gitea Actions : du push au déploiement

**Concept** : Tu as Gitea sur ton homelab. Configurer Gitea Actions (compatible GitHub Actions) pour automatiser : lint, tests, build Docker, push registre, déploiement K3s. Une pipeline CI/CD complète et auto-hébergée. Montrer que CI/CD n'est pas réservé à GitHub/GitLab.

**Ce que ça implique de ta part** : Projet homelab. Configurer le runner Gitea Actions, écrire les workflows. ~1-2 weekends.

**Carrière** : **D+A**. CI/CD est attendu partout. Le fait de le self-hoster montre une compréhension profonde.

---

## 17. Agents IA autonomes : construire un agent qui résout un vrai problème

**Concept** : Construire un agent IA qui fait quelque chose d'utile et de concret (pas un chatbot). Exemples : un agent qui monitore tes DAGs Airflow et crée des tickets quand ça casse, un agent qui analyse les logs et propose des corrections, un agent de veille technique qui résume les nouvelles publications. Utiliser l'OpenAI Agents SDK, crewAI, ou LangGraph.

**Ce que ça implique de ta part** : Projet homelab. Choisir le use case, implémenter l'agent, le déployer sur ton infra. ~2-3 weekends.

**Carrière** : **B+C**. Les agents IA sont le sujet de 2025-2026. Montre que tu es à la pointe. Le côté "résout un vrai problème" te différencie des tutos.

---

## 18. Sécuriser un homelab : hardening, réseau, secrets, audit

**Concept** : Documenter la sécurisation de ton infra. Network policies K3s, gestion des secrets (Ansible Vault vs Sealed Secrets vs External Secrets), HTTPS everywhere, fail2ban, audit de sécurité, principe de moindre privilège. Un sujet rarement couvert par les homelabbers.

**Ce que ça implique de ta part** : Audit et renforcement de ton infra existante. ~2 weekends.

**Carrière** : **D**. La sécurité est un différenciateur fort. Très peu de profils data s'en préoccupent.

---

## 19. dbt sur PostgreSQL : transformation de données déclarative sur un homelab

**Concept** : Installer dbt, le brancher sur ton PostgreSQL, réécrire une partie de tes transformations Nyukom ou Book Reco en dbt. Montrer les tests dbt, la documentation auto-générée, le lineage. Comparer avec l'approche Python/Pandas actuelle.

**Ce que ça implique de ta part** : Projet homelab. Apprendre dbt, migrer quelques transformations. ~1-2 weekends.

**Carrière** : **A fort**. dbt est devenu quasi-standard en data engineering. C'est le trou le plus facile à combler dans ton profil DE.

---

## 20. Scraping à grande échelle : architecture, anti-détection et éthique

**Concept** : Tu as une vraie expertise en scraping (Playwright, Scrapy, Selenium, FlareSolverr, moteur YAML). Documenter les patterns d'architecture pour du scraping en production à grande échelle : gestion du rate limiting, rotation de proxies, anti-détection, parallélisme, gestion des erreurs, respect des robots.txt. Un article de référence, pas un tuto débutant.

**Ce que ça implique de ta part** : Rien de nouveau — documenter ton expertise existante.

**Carrière** : **A+C**. Le scraping est une compétence niche très demandée. Se positionner comme expert sur le sujet.

---

## Résumé par effort et impact

| # | Article | Effort | Carrière | Comble une lacune ? |
|---|---------|--------|----------|---------------------|
| 1 | Renvoi blog DataKhi | Nul | Transversal | Non |
| 2 | Observabilité pipeline | 1-2 WE | B+D | **Oui** (observabilité) |
| 3 | Tests automatisés pipeline | 1-2 WE | A+B | **Oui** (tests) |
| 4 | Deep learning from scratch GPU | 3-5 WE | B | **Oui** (DL natif) |
| 5 | Feature store artisanal | 2-3 WE | B | Non |
| 6 | Model serving comparatif | 2 WE | B | Non |
| 7 | Data drift monitoring | 2 WE | B | Non |
| 8 | GitOps ArgoCD | 1-2 WE | D+A | Non |
| 9 | Système RAG complet | 2-3 WE | B+C | Non |
| 10 | Airflow sur K3s (retour XP) | Nul | A+D | Non |
| 11 | Comparatif orchestrateurs | 2-3 WE | A | Non |
| 12 | Lakehouse MinIO + DuckDB | 1-2 WE | A | **Oui** (Spark/lakehouse) |
| 13 | Streaming Redpanda/Kafka | 2 WE | A | **Oui** (streaming) |
| 14 | Flutter Virtual Try-On (retour XP) | Nul | C | Non |
| 15 | Terraform homelab | 2-3 WE | D+A | **Oui** (Terraform) |
| 16 | CI/CD Gitea Actions | 1-2 WE | D+A | Non |
| 17 | Agents IA autonomes | 2-3 WE | B+C | Non |
| 18 | Sécurité homelab | 2 WE | D | Non |
| 19 | dbt sur PostgreSQL | 1-2 WE | A | **Oui** (dbt) |
| 20 | Scraping à grande échelle | Nul | A+C | Non |
