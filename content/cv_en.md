---
title: "Resume"
description: "Nathan Leclercq — MLOps & Data Engineer"
showReadingTime: false
showDate: false
showAuthor: false
showTableOfContents: true
---

# Nathan Leclercq

[nathan.leclercq9@protonmail.com](mailto:nathan.leclercq9@protonmail.com) | [LinkedIn](https://www.linkedin.com/in/nathan-leclercq/) | [GitHub](https://github.com/nathanlq) | [Blog](https://nathan.leclercq.spacesheep.ovh/) | [Download PDF](/pdf/cv_nathan_leclercq_en.pdf)

---

## Profile

**MLOps & Data Engineer** at DataKhi for 3 years (apprenticeship then full-time). I design and operate end-to-end data + ML platforms: collection, pipelines, ML models, deployment, monitoring. Three recurring angles in my work: **targeted sovereignty** (taking back control of sensitive ML workloads without migrating everything off existing clouds), **infrastructure frugality** (measuring rather than guessing the energy cost of an ML cluster), **product eco-design** (environmental impact of ML systems, hands-on experience with Tossée + Ecobalyse). Master's in Machine Learning (Lille), background in mathematics.

---

## Talks & Publications

- **DevLille 2026** (June 2026, with Jonathan Fritsch) — *"Take back control of your data platform from the American giants"*: hands-on talk on deploying a modern data platform in private cloud (MinIO/Garage, PostgreSQL, DuckDB, K3s)
- **8 technical articles on the [DataKhi blog](https://www.datakhi.fr/fr/blog)** (Jan 2026), including: sovereign data platforms, self-hosted S3 storage, migration to open source, Airflow → Kestra migration, ML for demand forecasting, database architectures for recommendation systems
- **Technical articles on [my personal blog](https://nathan.leclercq.spacesheep.ovh/posts/)** (2024-2026): Homelab series (5 posts), Book Reco series (6 posts), Cloud Nord 2024 review, melody harmonization research

---

## Professional Experience

### DataKhi — Data Consulting Firm, Tourcoing (2023 - present)

**MLOps & Data Engineer — Nyukom Project** · Full-time · Oct 2025 - present
- End-to-end telecom data platform: collection (3CX web scraping, Centreon API), object data lake, PostgreSQL star schema warehouse, Power BI reporting
- Full infrastructure deployed and operated: K3s, Airflow, Ansible (5 roles), private OCI registry
- **Ongoing migration of object storage from MinIO to Garage** (European S3) for sensitive workloads, J-1 mirror maintained during transition
- Multi-tenant with partitioning, idempotency, historical backfill
- Stack: Airflow 3, K3s, Ansible, Docker, PostgreSQL 17, MinIO, Garage, Playwright, Python

**Data Engineer — French Companies Reference ETL (SIRENE)** · Full-time · 2025 - present
- PostgreSQL ingestion pipeline for ~14.8M active companies, ~23M establishments, enriched with BCE/INPI financial ratios (~6.3M rows) and calls to the official French Business Directory API
- Incremental mode (UPSERT) or full mode (atomic swap preserving API enrichments), error-tolerant, idempotent
- Data warehouse schema `d_entreprise`, `d_etablissement`, `d_finance`, `d_dirigeant`
- Stack: Python, PyArrow, Parquet, INSEE bulk data, Business Directory API

**Data + Platform Engineer — Sovereign S3 Benchmark (Garage vs MinIO)** · Full-time · 2025 - 2026
- Designed and ran a Garage vs MinIO benchmark (3-node cluster + single-node) to inform object storage choice for sensitive workloads
- Measurements: DuckDB reads on a multi-GB parquet dataset, boto3 writes, resilience test (node failure + recovery verification)
- Reproducible automated test bench (multi-node Docker Compose + deployment scripts), technical foundation for the DevLille 2026 talk
- Stack: Garage, MinIO, DuckDB, boto3, Docker Compose, Python

**Data Engineer — Hall U Need Data Infrastructure (Microsoft Fabric + Azure Data Factory)** · Full-time (continued from apprenticeship) · 2023 - present
- Operating and evolving an existing hybrid data infrastructure for a mid-sized restaurant company: Microsoft Fabric (data warehouse + notebooks), Azure Data Factory (flow orchestration), custom Playwright scraping pipelines for non-Azure sources
- Day-to-day run: handling production incidents, cloud cost monitoring, flow monitoring
- Progressive enrichment driven by client requests: new sources (POS systems, reservations, weather, HR, events), new flows, cost and reliability optimizations
- Stack: Microsoft Fabric, Azure Data Factory, Azure SQL, Python, Playwright, Pandas

**ML Engineer — Hall U Need Demand Forecasting** · Full-time (continued from apprenticeship) · 2023 - present
- Industrialized a restaurant demand forecasting model (XGBoost quantile regression) on the database fed by the Fabric infra above: 28 independent models, advanced feature engineering (weather, calendar, public holidays, bridge days, events, J-X reservations)
- Custom Huber loss function, confidence interval calibration, non-regression tests (Pearson ≥ 0.999)
- Full pipeline: Microsoft Fabric collection → training → prediction, Makefile workflow

**Data + MLOps Engineer — Tossée Project** · Apprenticeship · 2023 - 2025
- Complete data ecosystem for an eco-responsible fashion aggregator (~15 sub-projects, publicly archived under AGPL v3)
- **Environmental impact scoring** via Ecobalyse API, multi-brand (67 YAML brands), product embedding ML pipeline for semantic search
- Large-scale crawling and scraping (Scrapy + Playwright + FlareSolverr + custom YAML rules engine)
- FastAPI + PostgreSQL/pgvector backend, Flutter mobile app (virtual try-on DM-VTON, barcode scanning, multi-provider OAuth, geolocation), React/TypeScript browser extension
- AI agent (OpenAI Agents SDK) for automatic data extraction from HTML
- Hybrid on-premise / Azure deployment (Functions, Blob)

**FullStack Developer — Internship** · 2023 · 4 months
- Power BI versioning system: C++ backend (report differentials), React frontend, Electron distribution

---

### Music Teacher · 2017 - present
- Saxophone (jazz, soul) and music theory — private lessons and music schools

---

## Technical Skills

**MLOps & ML Engineering**
- End-to-end production ML pipelines: training → serving → monitoring → reindex
- Local LLM serving (Ollama, shared GPU), embedding pipelines (Nomic Embed Text, sentence-transformers, CamemBERT)
- Production RAG: pgvector + tsvector + trigram + RRF, Model Context Protocol (MCP SDK)
- XGBoost (quantile regression), feature engineering, temporal cross-validation, custom loss functions, interval calibration
- LLM observability: Tempo OTLP, custom Prometheus metrics, Grafana alerting

**Data Engineering**
- End-to-end ETL pipelines, star schema, partitioning, idempotency, backfill
- Apache Airflow (DAGs, custom operators), Kestra (evaluating), Microsoft Fabric, Azure Data Factory
- Advanced PostgreSQL, PyArrow / Parquet, MinIO / Garage (S3-compat object storage), DuckDB
- Hybrid data infrastructure maintenance (run, cloud cost monitoring, incidents, schema evolution)

**Infrastructure / DevOps / Frugality**
- Kubernetes (K3s in production), Docker, Ansible (IaC, roles, vault, sealed-secrets)
- Proxmox (4-node home cluster), GPU sharing (nvidia-device-plugin time-slicing)
- Full observability stack: Prometheus, Grafana, Loki, Tempo
- Energy measurement: Kepler (eBPF + RAPL for per-pod consumption), smart plugs / Home Assistant
- CI/CD: Forgejo Actions, self-hosted Renovate, private OCI registry
- Azure (Fabric, Functions, Blob, DevOps)

**Web Scraping & Crawling**
- Playwright (headless), Scrapy, BeautifulSoup, FlareSolverr (anti-bot)
- Custom YAML rules engines (homegrown DSL)

**Development**
- Python (FastAPI, Pandas, scikit-learn, PyTorch), SQL, TypeScript (React), Dart (Flutter)
- Familiar with: Go, Rust, Haskell, C++, GraphQL

**Scientific / Competitive Programming**
- Julia (competitions: Google Hash Code, Reply Challenge, Cloudflight)
- R, NumPy / SciPy, Polars

---

## Personal Projects

**MLOps Homelab Platform** · 2024 - present
- Proxmox + K3s cluster (4 nodes including a RTX 4060 Ti GPU) fully operated via Ansible
- Services in production: Ollama (qwen3:14b), Forgejo + Actions, Vaultwarden, Miniflux, Renovate, knowledge-mcp, Prom/Grafana/Loki/Tempo monitoring
- Power management: WoL + automated nightly shutdown, on-demand scale-to-zero, GPU KEEP_ALIVE
- [Published technical articles](https://nathan.leclercq.spacesheep.ovh/posts/)

**knowledge-mcp — Personal RAG exposed via MCP** · 2026 - present
- Personal semantic RAG engine over ~35k chunks of documents (markdown, code, articles), exposed as a Model Context Protocol server for Claude / Cursor
- Architecture: pgvector + tsvector + trigram + RRF, Nomic Embed via Ollama
- Deployed in production on the homelab: HTTP Deployment (CPU, ~50ms per query), GPU reindex CronJob
- Stack: Python, pgvector, Nomic Embed, Ollama, MCP SDK, K3s, Forgejo Actions

**Book Recommendation System** · 2023 - 2025
- Full data pipeline: large book catalogue scraping, embeddings (TF-IDF + CamemBERT), FastAPI API, PostgreSQL/pgvector, MLflow, Vue.js interface
- [Published technical articles](https://nathan.leclercq.spacesheep.ovh/posts/)

**Algorithms Club** · 2020 - 2024
- Preparation and participation in competitive programming contests
- Optimized solutions in Julia · Google Hash Code, Reply Challenge, Cloudflight

**Research: Melody Harmonization** · 2024
- Comparative study of models and algorithms for automatic melody harmonization

---

## Education

**Master's in Machine Learning** · University of Lille · 2023 - 2025
- Deep Learning, NLP, MLOps · LLM deployment on GPU infrastructure

**Bachelor's in Computer Science** · University of Lille · 2020 - 2023
- Advanced algorithms, distributed architecture, full-stack development

**Mathematics Studies** (3 years) · University of Lille · 2017 - 2020
- Numerical analysis, probability/statistics, applied linear algebra

---

## Languages

- French: native
- English: professional (TOEIC 885)

---

## Interests

- Music: jazz/soul saxophone, orchestra
- Sports: daily cycling, badminton
- Reading: science fiction, technical essays (digital sobriety, AI Act, systems design)
- Tabletop role-playing games
