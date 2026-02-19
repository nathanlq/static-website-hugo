# TODO — Refonte site portfolio Nathan Leclercq

## SITE — Actions immédiates (cette semaine)

- [ ] **Photo de profil** — Trouver/prendre une photo sobre (pas besoin d'un studio, un portrait net suffit). La mettre dans `assets/` et configurer `params.author.image` dans `config/_default/languages.fr.toml`.
- [ ] **Vérifier les liens DataKhi** — Remplacer les liens génériques (`https://www.datakhi.fr/fr/blog`) par les URLs directes de chaque article dans `content/posts/datakhi-blog.md` et `content/projets.md`.
- [ ] **Relire les CV** — Vérifier que tout est factuel, qu'il n'y a pas d'erreur de date ou de chiffre.
- [ ] **Tester le site mobile** — Vérifier le rendu sur téléphone (responsive).
- [ ] **Déployer** — Mettre à jour le playbook Ansible si nécessaire, penser au `make build` (qui génère les PDFs avant le build Hugo).

---

## IMAGES — Propositions par page/article

### Page Projets (`content/projets.md`)
- **Nyukom** : schéma d'architecture du pipeline (Sources → MinIO → PostgreSQL → Power BI). Tu peux le faire avec draw.io, Excalidraw, ou Mermaid.
- **Hall U Need** : screenshot d'un dashboard de prédictions (si le client t'autorise), ou un graphique matplotlib prédictions vs réalité.
- **Tossée** : screenshot de l'app mobile (virtual try-on), ou de l'extension navigateur, ou schéma de l'architecture multi-projets.
- **Homelab** : photo de ton setup physique (serveurs, câbles, rack si tu en as), ou screenshot du dashboard Grafana.
- **Book Reco** : screenshot de l'interface Vue.js ou du Swagger API.

### Articles de blog (thumbnails pour les cards)
Les images sont à placer en tant que `featured.jpg` ou `featured.png` dans un dossier par article (Blowfish page bundles), ou directement référencées dans le frontmatter avec `image:`.

- **Série Homelab** : schéma réseau, screenshot Proxmox, dashboard Grafana, photo du matériel
- **Série Book Reco** : diagramme d'architecture, screenshot API Swagger, visualisation d'embeddings
- **Cloud Nord 2024** : photo de la conférence ou logo de l'événement
- **Harmonisation mélodies** : partition annotée ou visualisation musicale
- **Hugo** : screenshot du site

Pour ajouter une thumbnail à un article, 2 méthodes :
1. Frontmatter : `image: "thumbnail.jpg"` (image dans `static/` ou `assets/`)
2. Page bundle : renommer `homelab0.md` en `homelab0/index.md` et mettre `featured.jpg` à côté

---

## ARTICLES — Échéancier hiérarchisé

### Phase 1 — Fondations Data Engineering solides (mars - août 2026)
*Combler les lacunes techniques les plus visibles. Impact CV immédiat.*

| Mois | Article | Effort | Lacune comblée |
|------|---------|--------|----------------|
| **Mars 2026** | Retour DataDays 2026 | 0 (rédaction) | — |
| **Avril 2026** | Tests automatisés pour pipelines data (pytest, Great Expectations) | 1-2 WE | Tests |
| **Mai 2026** | Observabilité pipeline (OpenTelemetry, alerting) | 1-2 WE | Observabilité |
| **Juin 2026** | dbt sur PostgreSQL | 1-2 WE | dbt (standard DE) |
| **Juil 2026** | Airflow sur K3s (retour d'XP) | 0 (rédaction) | — |
| **Août 2026** | Data drift et monitoring de modèles ML (Evidently) | 2 WE | Monitoring ML |

**Logique :** Mars = article gratuit post-conférence, tu démarres sans pression. Ensuite les lacunes les plus faciles et visibles (tests, observabilité), puis dbt (standard DE). Airflow est un mois de rédaction pure = respiration. Le drift monitoring clôture la phase avec un signal MLOps.

**Projet homelab :** Prendre Book Reco, ajouter pytest + Great Expectations, puis OpenTelemetry + alerting, puis dbt — tout sur le même PostgreSQL. Le drift monitoring se fait sur HUN.

### Phase 2 — MLOps + expertise opérationnelle (sept 2026 - jan 2027)

| Mois | Article | Effort |
|------|---------|--------|
| **Sept 2026** | Servir un modèle ML (BentoML/FastAPI/Seldon) | 2 WE |
| **Oct 2026** | Scraping à grande échelle (retour d'XP) | 0 (rédaction) |
| **Nov 2026** | Lakehouse MinIO + DuckDB | 1-2 WE |
| **Déc 2026** | *Pause — vacances* | — |
| **Jan 2027** | Terraform pour homelab | 2-3 WE |

**Logique :** Model serving puis un mois de rédaction (scraping = vraie expertise différenciante). Lakehouse pour le signal "modern data stack". Décembre = pause réelle. Terraform ouvre la phase Platform Engineering.

**Projet homelab :** Déployer BentoML/Seldon sur K3s. DuckDB sur MinIO. Terraformer l'infra existante.

### Phase 3 — Platform Engineering (fév - mai 2027)

| Mois | Article | Effort |
|------|---------|--------|
| **Fév 2027** | GitOps ArgoCD sur K3s | 1-2 WE |
| **Mars 2027** | CI/CD Gitea Actions | 1-2 WE |
| **Avr 2027** | Sécurité homelab (hardening, secrets, réseau) | 2 WE |

**Logique :** Terraform + ArgoCD + CI/CD + Sécurité forment un bloc Platform Engineering cohérent. C'est le profil le plus monnayable en freelance data : quelqu'un qui sait construire ET opérer.

---

## RYTHME

**1 article par mois, avec une pause en décembre.** Les mois "rédaction seule" (retour d'XP, conférence) servent de respiration.

**Workflow :**
1. Semaines 1-2 : projet homelab (code, config, tests)
2. Semaine 3 : rédaction + screenshots + schémas
3. Semaine 4 : relecture, publication

**Résultat à mai 2027 :** 15 articles actuels + 12 nouveaux = **27 articles publiés** + 5 articles DataKhi.

---

## RÉSEAU — Préparation long terme freelance

*Tu es en CDI. L'objectif n'est pas de vendre des services maintenant, mais de construire la visibilité et le réseau qui rendront la transition naturelle le moment venu.*

- [ ] **Meetup PostgreSQL Lille** — Y aller régulièrement. Objectif : être un visage connu, pas juste un spectateur. Poser des questions, discuter après les talks.
- [ ] **DataDays mars 2026** — Avec DataKhi. Écrire l'article de retour dans la foulée (cf. échéancier). Prendre des contacts.
- [ ] **LinkedIn** — Poster 1-2x/mois : résumé d'un article publié, retour de meetup/conférence, apprentissage technique court. Pas besoin de devenir "influenceur", juste être visible.
- [ ] **Contributions open source** — Si tu trouves un bug ou une amélioration sur un outil que tu utilises (Airflow, dbt, DuckDB...), ouvre une issue ou une PR. Même petite, ça compte.

### Outils à explorer plus tard (pas urgent)
- **Malt** : plateforme française de freelances tech. Tu crées un profil avec tes compétences, les clients te trouvent ou tu réponds à des missions. Forte présence data/dev. C'est le principal marketplace freelance en France.
- **Comet** : similaire mais positionné plus haut de gamme (missions longues, grands comptes, TJM plus élevés). Sélectif à l'entrée. Pertinent quand tu auras 4-5 ans d'XP.

---

## RÉSUMÉ — Impact sur le profil

| Lacune actuelle | Article | Quand |
|-----------------|---------|-------|
| Tests automatisés | pytest, Great Expectations | Avril 2026 |
| Observabilité | OpenTelemetry, alerting | Mai 2026 |
| dbt / outils DE standard | dbt sur PostgreSQL | Juin 2026 |
| Monitoring de modèles | Data drift, Evidently | Août 2026 |
| Model serving | BentoML, Seldon | Sept 2026 |
| Spark / lakehouse | DuckDB + MinIO | Nov 2026 |
| Terraform | Terraform homelab | Jan 2027 |
| GitOps | ArgoCD sur K3s | Fév 2027 |
| CI/CD | Gitea Actions | Mars 2027 |
| Sécurité infra | Hardening, secrets | Avr 2027 |
