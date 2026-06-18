# CLAUDE.md

## Project Overview

Blog technique et portfolio de Nathan Leclercq, en Hugo. En ligne sur
`https://nathan.leclercq.spacesheep.ovh/`.

## Hébergement & déploiement

- **Hébergé sur le NAS Synology** (`192.168.1.165:443`), exposé via Nginx Proxy
  Manager. Voir `~/Documents/perso/infra-homelab/docs/inventaire-actuel.md`
  (ligne « ne pas toucher »). Le site n'est PAS sur le cluster k3s et n'est PAS
  géré par l'Ansible de `infra-homelab`.
- **Build** : `hugo` → sortie dans `public/`.
- **Publication vers le NAS** : non scriptée dans ce repo (pas de CI Forgejo,
  pas de rôle Ansible trouvé). Étape faite à la main par Nathan — TODO : documenter
  la commande exacte ici une fois confirmée.

## Tech Stack

- **Hugo** (static site generator)
- **Thème** : **Blowfish** (`theme = "blowfish"` dans `config/_default/config.toml`,
  docs : https://blowfish.page). `themes/hermit-v2` existe encore mais n'est PAS utilisé.
- **Contenu** : Markdown
- **Git remotes** : `forgejo` (`git.spacesheep.ovh`, self-hosted) + `origin`
  (`codeberg.org`). Branche `master`.

## Configuration (éclatée dans `config/_default/`)

- `config.toml` : baseURL, `languageCode = "fr"`, `theme = "blowfish"`, taxonomies,
  outputs (home : HTML/RSS/JSON)
- `params.toml` : params Blowfish — homepage `layout = "profile"`,
  `homepageImage = "spacesheep.jpg"` (image de la page d'accueil), article/list/footer
- `menus.fr.toml` : menu = Projets, Blog, À propos, CV (FR), CV (EN)
- `languages.fr.toml`, `markup.toml`

## Content Structure

```
content/
  _index.md         # Page d'accueil (titre + description)
  about.md          # "À propos"
  cv_fr.md          # CV français (AVEC frontmatter Blowfish)
  cv_en.md          # CV anglais (AVEC frontmatter)
  projets.md        # Page projets
  posts/            # Articles : séries Homelab + Book Reco, Cloud Nord 2024, etc.
```

Assets images : `assets/` (traités par Hugo, ex. `homepageImage`) et `static/img/`
(servis tels quels, référencés en `/img/...`).

## CV PDF téléchargeables — /!\ GOTCHA

Servis à `/pdf/cv_nathan_leclercq_{fr,en}.pdf` (dans `static/pdf/`).

Le `Makefile` (`make cv-pdf` / `make build`) REGÉNÈRE ces PDF depuis `pdf/cv_fr.md`
via pandoc. MAIS le PDF FR servi a été remplacé par la version soignée (awesome-cv,
LaTeX) maintenue dans `~/Documents/candidatures/` (`cv_fr.tex` → `cv_fr.pdf`).
=> Ne PAS lancer `make cv-pdf`/`make build` sans le vouloir : ça écraserait le beau
CV avec l'ancienne version pandoc. Pour mettre à jour le CV servi : recompiler dans
`~/Documents/candidatures/` puis copier le PDF dans `static/pdf/`.

## Important Notes

- Les pages CV (`cv_fr.md`, `cv_en.md`) ONT un frontmatter (title, description,
  showReadingTime, showTableOfContents…).
- `.gitignore` exclut `/public/` et `/resources/_gen/`.
- Override de layout : `layouts/partials/`.

## Current Goals

- **Positionnement MLOps frugal et souverain** : ce blog est l'asset central de la
  stratégie « référent contenu MLOps frugal » vers freelance full remote 2029-2030.
  Voir `~/Documents/perso/TODO.md`. Tout nouvel article doit renforcer la niche.
- **CV à jour** (fait, juin 2026) : statut CDI DataKhi, positionnement Data/MLOps,
  talk DevLille 2026, projets Nyukom/HUN/SIRENE. Ne plus dire « étudiant en Master ».
  Mission client `drive-knowledge-mcp` retirée des CV publics (confidentialité).
- **Article DevLille** (à venir) : la photo de scène est parquée dans
  `static/img/devlille-2026.jpg` (et `assets/devlille-2026.jpg`), prête à insérer.
- **Nouveaux posts** : compléter, sans dupliquer, les 8 articles du blog DataKhi.

## DataKhi Blog Articles (par Nathan — NE PAS dupliquer)

8 articles au total (jan 2026 et après). Connus :
1. Construire une plateforme de données souveraine — MinIO/PostgreSQL/Airflow/K3s
2. Stockage de fichiers auto-hébergé : stockage objet et alternatives — S3, Garage, MinIO
3. Passer à l'open source : comment ça se passe concrètement — migration infra
4. Anticiper l'affluence grâce au machine learning — XGBoost, prévision de demande
5. Systèmes de recommandation : quelle architecture de BDD choisir — Graph vs Vector DB
6. Migration Airflow → Kestra
(+ 2 autres — à compléter en relisant https://www.datakhi.fr/fr/blog)
