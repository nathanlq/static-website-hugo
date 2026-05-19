# Propositions d'articles — catalogue filtré (MLOps frugal et souverain)

Catalogue d'idées d'articles aligné avec la direction "référent contenu MLOps frugal et souverain" (cf. `~/Documents/perso/TODO.md`). Les articles non-alignés (data eng pur sans angle MLOps, infra pure sans angle frugalité, side-projects hors positionnement) ont été retirés du précédent catalogue.

Note de tonalité pour tous les articles : l'angle souveraineté n'est PAS "remplacer AWS/Azure/GCP" — c'est "monter du self-host à côté du cloud existant pour les workloads sensibles (modèles, RAG, données users), diversifier les dépendances critiques, reprendre le contrôle ciblé". Cette nuance ouvre le marché aux clients déjà sur cloud US (= 80% du marché), au lieu de leur dire "il faut tout migrer".

À piocher selon les opportunités et les phases du plan opérationnel.

---

## 1. Renvoi vers le blog DataKhi

**Concept** : Un post court qui présente tes articles publiés sur le blog DataKhi, avec le contexte personnel de chacun (pourquoi tu l'as écrit, sur quelle mission). Pas de paraphrase, juste le renvoi.

**Ce que ça implique de ta part** : Rien. Valider le texte.

**Alignement direction** : Transversal. Crédibilise ton blog perso en montrant que tu publies aussi en pro.

---

## 2. Observabilité d'un pipeline data + ML : OpenTelemetry, logs structurés, alerting

**Concept** : Prendre un de tes pipelines (Nyukom côté Datakhi anonymisé, ou knowledge-mcp côté perso) et ajouter une couche d'observabilité complète : logs structurés (structlog), traces OpenTelemetry → Tempo, métriques custom Prometheus, alerting (Alertmanager ou Grafana alerts). Documenter le avant/après en termes de signal opérationnel.

**Ce que ça implique de ta part** : Instrumenter une app existante. ~1-2 weekends.

**Alignement direction** : MLOps core. L'observabilité ML est une des compétences les plus regardées dans les offres MLOps.

---

## 3. Sustainable MLOps : mesurer + optimiser un cluster qui sert du RAG/LLM

**Concept** : Comment mesurer la conso énergétique d'un cluster k3s qui sert des modèles ML/RAG (Ollama, knowledge-mcp, embedding pipelines). Outils : Kepler (per-pod via eBPF + RAPL), smart plug Shelly pour le total mur, dashboards Grafana. Avant/après optim (schedutil governor, PowerTOP autotune, KEDA scale-to-zero, retentions courtes, drops services inutiles).

**Ce que ça implique de ta part** : Cleanup homelab + Kepler installés + Shelly branchée (déjà sur le TODO racine). ~10h rédaction + capture des graphes.

**Alignement direction** : Cœur de la niche frugal. Quasi-vide en français. **Candidat fort HN**.

---

## 4. RAG d'entreprise en production via MCP — retex knowledge-mcp / drive-knowledge-mcp

**Concept** : Comment mettre un RAG d'entreprise en production accessible via Model Context Protocol, **sans envoyer les documents sensibles à un LLM tiers**. Architecture hybride pgvector + tsvector + trigram + RRF, embeddings Nomic Embed via Ollama (local), indexation incrémentale via delta. Couvrir aussi le côté MLOps : déploiement (k8s), monitoring du pipeline d'embedding, gestion du modèle Nomic, CronJob reindex GPU. Angle commercial fort : tu peux brancher le RAG sur des sources SharePoint/Confluence/Drive qui vivent déjà dans le cloud US d'une boîte, et garder l'intelligence (embeddings + LLM) chez toi. Pas un remplacement de SharePoint — un complément qui reprend le contrôle de la couche IA.

**Ce que ça implique de ta part** : v0 drive-knowledge-mcp livré côté Datakhi + accord pour le détailler publiquement (anonymisé). ~12h.

**Alignement direction** : RAG en prod est un sous-domaine MLOps central, MCP est un standard montant. **Candidat fort HN, awesome-mcp PR, awesome-rag PR**.

---

## 5. Orchestration de pipelines MLOps : Airflow vs Kestra vs n8n

**Concept** : Comparatif sur un pipeline ETL + ML réel (extraction SIRENE open data INSEE → enrichissement embeddings → indexation pgvector). Trois outils, mêmes objectifs, comparer expérience développeur, performances, facilité de déploiement sur k3s, gestion des dépendances ML, monitoring. Inclure le volet "orchestration de jobs ML" (batch inference, reindex périodique).

**Ce que ça implique de ta part** : Kestra déployé en local + pipeline porté en 3 versions. ~15h, c'est le plus lourd.

**Alignement direction** : MLOps + data eng. Comparatif quasi-vide en français.

---

## 6. Servir un modèle ML en production : comparatif BentoML vs vLLM vs TGI vs Ollama

**Concept** : Prendre un modèle (un quantile XGBoost type HUN et/ou un LLM 7B) et le servir de plusieurs manières. Comparer les performances (latence, throughput, conso GPU), la facilité de déploiement sur k3s, le monitoring, le versionning, la cohabitation GPU avec d'autres workloads. Inclure l'angle frugalité : VRAM consommée, modèles quantifiés.

**Ce que ça implique de ta part** : Déployer 3-4 stacks de serving sur k3s + benchmarks reproductibles. ~2-3 weekends.

**Alignement direction** : Model serving = MLOps core. L'angle quantification + frugalité est rarement abordé.

---

## 7. Data drift et monitoring de modèles ML en production

**Concept** : Détection de data drift et concept drift sur un modèle perso (XGBoost HUN si autorisé, sinon un modèle simulé). Outils : Evidently ou Whylabs, intégration Prometheus/Grafana pour les alertes. Cas concret avec données simulées ou réelles (météo exceptionnelle, changement comportement).

**Ce que ça implique de ta part** : ~2 weekends.

**Alignement direction** : MLOps core. Le monitoring de modèles est le sujet MLOps le plus demandé et le moins maîtrisé.

---

## 8. LLM observability self-hosted avec Langfuse + Tempo + Prom

**Concept** : Comment instrumenter une app LLM (knowledge-mcp côté perso) pour avoir traces, eval, prompt versioning, monitoring qualité réponse. Stack : Langfuse + Tempo OTLP + Prometheus + Grafana, tout chez soi. Comparer avec les solutions SaaS (LangSmith, etc.) sur les axes coût, souveraineté des prompts/traces (qui peuvent contenir de la donnée sensible client), et lock-in.

**Ce que ça implique de ta part** : Langfuse déployé sur k3s + knowledge-mcp instrumenté. ~1-2 weekends.

**Alignement direction** : MLOps moderne, niche très peu couverte. Angle commercial : les prompts d'une app LLM d'entreprise contiennent souvent des morceaux de données utilisateurs / docs internes — les envoyer à un SaaS US d'observabilité fait passer ces données par un tiers. Self-host = un cas où le contrôle est légitime, pas idéologique.

---

## 9. Embedding models pour le français : comparatif Nomic vs BGE-M3 vs Jina vs OpenAI

**Concept** : Benchmark sur corpus français (extraits SIRENE / posts blog / corpus knowledge-mcp). Métriques : MRR, recall@k, latence, RAM, coût. Inclure l'aspect "local vs API" et l'impact sur la souveraineté.

**Ce que ça implique de ta part** : Benchmark scripts + corpus + capture résultats. ~2 weekends.

**Alignement direction** : RAG + souveraineté. Très peu de benchmarks FR disponibles publiquement.

---

## 10. Feature store artisanal avec PostgreSQL + Redis

**Concept** : Feature store minimaliste sur ton homelab. PostgreSQL (offline store) + Redis (online store pour serving temps réel). Point d'entrée unique pour le feature engineering, versionning, backfill. Comparer avec Feast/Tecton (montrer ce qu'on gagne et ce qu'on perd en restant artisanal).

**Ce que ça implique de ta part** : Coder le feature store en Python + intégration avec un pipeline existant (HUN ou Book Reco). ~2-3 weekends.

**Alignement direction** : MLOps avancé, différenciant. Très peu de profils juniors ont construit un feature store maison.

---

## 11. Lakehouse léger et contrôlé : MinIO/Garage + DuckDB pour analytics ML

**Concept** : Architecture lakehouse sur infra qu'on possède. Stockage MinIO ou Garage (S3-compat), DuckDB pour le traitement, format Parquet/Iceberg. Démontrer que le pattern lakehouse n'est pas réservé à Databricks/Snowflake — il peut tourner sur du hardware modeste et coexister avec un Databricks/Snowflake existant pour les use cases qui n'ont pas besoin du géant cloud. Inclure un cas d'usage ML (feature engineering sur lakehouse).

**Ce que ça implique de ta part** : DuckDB + Iceberg/Parquet sur ton MinIO/Garage, quelques transformations. ~1-2 weekends.

**Alignement direction** : Souveraineté ciblée + data eng moderne. Aligne directement avec ton talk DevLille. Angle commercial : tu n'attaques pas Databricks ou Snowflake, tu offres une option pour les workloads qui ne justifient pas leur coût ou leur dépendance.

---

## 12. Airflow sur K3s : retex et pièges

**Concept** : Retex pratique sur le déploiement d'Airflow en production sur K3s (sur Nyukom). Choix Helm vs manifestes custom, CeleryExecutor vs KubernetesExecutor, gestion des ressources, sync DAGs, problèmes réseau inter-namespaces, monitoring. Pas un tuto, un retour d'expérience honnête.

**Ce que ça implique de ta part** : Rien — documenter ce que tu as déjà fait.

**Alignement direction** : MLOps + ops. Article "gratuit" (rédaction pure), excellent pour la cadence.

---

## 13. Agents IA autonomes pour MLOps : automatiser le monitoring d'un cluster ML

**Concept** : Construire un agent IA qui fait quelque chose d'utile et concret côté MLOps. Exemple : un agent qui monitore Airflow + Prometheus, détecte les anomalies sur les pipelines ML, et ouvre des issues Forgejo avec contexte. Stack : Claude / qwen3 via Ollama, Model Context Protocol (réutiliser le pattern knowledge-mcp), Forgejo API. Pas un chatbot — un assistant ops.

**Ce que ça implique de ta part** : Coder l'agent + l'intégrer à ton homelab. ~2-3 weekends.

**Alignement direction** : Agents IA = sujet 2025-2026, et tu as déjà la stack MCP en place. Te positionne sur l'IA appliquée à l'ops.

---

## 14. Postmortem MLOps Tossée — un pipeline ML d'écoconception textile qui n'est pas allé en prod

**Concept** : Retex honnête sur Tossée (projet archived, AGPL v3, public sur GitHub) : un pipeline ML de scoring d'impact environnemental textile, multi-marques (67 brands YAML), end-to-end (Scrapy → Playwright → normalisation → PyTorch embeddings → FastAPI + pgvector → app mobile Flutter + extension navigateur). Qu'est-ce qui a marché, qu'est-ce qui n'a pas, pourquoi le projet n'est pas allé en production, ce qu'on referait autrement. Très différenciant : peu de postmortems MLOps publics, surtout sur des projets à impact env.

**Ce que ça implique de ta part** : Rien à coder, c'est de la rédaction sur du vécu. Le repo est déjà public et documenté. ~10-15h de rédaction propre.

**Alignement direction** : Écoconception produit (Ecobalyse, scoring env) + MLOps complet + retex honnête. Couvre une dimension qui complète bien "frugalité infra" : pas seulement optimiser un cluster, mais mesurer l'impact d'un produit ML qu'on construit. Angle marché : AI Act + scope 3 + Boavizta + Green Software Foundation.

---

## 15. Scraping à grande échelle : architecture, anti-détection, éthique

**Concept** : Documenter ton expertise scraping (Playwright, Scrapy, Selenium, FlareSolverr, moteur YAML maison) à partir du retex Tossée et Nyukom. Patterns d'architecture en production : rate limiting, rotation de proxies, anti-détection, parallélisme, gestion erreurs, robots.txt. Article de référence, pas un tuto débutant.

**Ce que ça implique de ta part** : Rien — documenter ton expertise existante. ~0 weekend (rédaction pure).

**Alignement direction** : Compétence niche très demandée, différenciante. Indirectement lié MLOps (collecte de données pour training).

---

## 16. Générateur de covers d'articles en code (méta-post)

**Concept** : Comment générer les images de cover de ce blog en code, paramétré par embedding du post (Nomic via Ollama, déjà déployé). Algorithme génératif (flow field, Voronoï, reaction-diffusion) sous contrainte d'un mot-clé / icône qui transparait. Refuser stock photo + Midjourney + IA bloated. Inclure le code complet du générateur.

**Ce que ça implique de ta part** : Générateur fonctionnel pour 5+ posts (cf. `~/Documents/perso/TODO-blog-covers.md`). ~3 weekends total dont une partie pour la rédaction.

**Alignement direction** : Aligne sobriété + tech + créatif. Méta-article qui montre que tu pratiques ce que tu prêches.

---

## Hors catalogue (volontairement supprimés)

Pour mémoire, articles présents dans la version précédente du catalogue mais retirés car non-alignés avec la direction MLOps frugal et souverain :

- Tests automatisés pour pipelines data (data eng pur, pas MLOps core)
- Deep learning from scratch sur GPU (trop large, déjà couvert par Tossée embeddings)
- GitOps ArgoCD sur K3s (infra pure, pas urgent pour la niche)
- Streaming Redpanda/Kafka (pas core MLOps frugal)
- App mobile Flutter Virtual Try-On (off-topic positionnement)
- Terraform pour homelab (infra pure, et tu as déjà Ansible qui couvre)
- CI/CD Gitea Actions (devenu Forgejo Actions, déjà en place, juste retex éventuel à intégrer dans un autre article)
- Sécurité homelab (utile mais marginal pour la niche)
- dbt sur PostgreSQL (data eng standard, pas MLOps central)

Si une opportunité ou une mission concrète ressuscite l'un de ces sujets dans le futur, c'est OK de le ressortir — mais ce n'est plus prioritaire dans la cadence d'articles 2026.
