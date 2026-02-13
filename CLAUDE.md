# CLAUDE.md

## Project Overview

Personal technical blog and portfolio for Nathan Leclercq, built with Hugo (static site generator). Hosted at `https://nathan.leclercq.spacesheep.ovh/`, deployed via Ansible to a self-hosted server behind Nginx Proxy Manager.

## Tech Stack

- **Hugo** (static site generator)
- **Theme**: [hermit-v2](https://github.com/1bl4z3r/hermit-V2) (git submodule in `themes/hermit-v2`)
- **Content**: Markdown
- **Deployment**: Ansible playbook, Nginx Proxy Manager (HTTPS)
- **Git remote**: `git.spacesheep.ovh` (self-hosted Gitea)

## Content Structure

```
content/
  about.md          # Page "À propos" - portfolio description
  cv_fr.md          # CV français (Markdown, no frontmatter)
  cv_en.md          # CV anglais (Markdown, no frontmatter)
  posts/
    homelab0-4.md   # Série Homelab (5 articles) - Proxmox, monitoring, stockage, services, automatisation
    bookrecopart0-5.md  # Série Book Reco (6 articles) - scraping, transformation, embeddings, API, déploiement
    cloudnord2024.md    # Retour Cloud Nord 2024
    hugo.md             # Tutoriel Hugo
    melodyharmony.md    # Recherche harmonisation de mélodies
```

## Configuration

- `config.toml`: Hugo configuration
  - `baseURL`: `https://nathan.leclercq.spacesheep.ovh/`
  - `languageCode`: `fr-fr`
  - `theme`: `hermit-v2`
  - Features: code highlighting, read time (in French), related posts, copy button, scroll to top
  - Social links: LinkedIn, GitHub
  - Menu: Posts, À propos, Curriculum Vitae (FR), Resume (EN)

## Development

```bash
# Local development
hugo server

# Build
hugo

# Theme is a git submodule - initialize on fresh clone
git submodule update --init --recursive
```

## Important Notes

- **CV pages** (`cv_fr.md`, `cv_en.md`) have **no Hugo frontmatter** - they are plain Markdown rendered as standalone pages
- **Posts** use frontmatter with `title`, `date`, `draft`, `tags`, `description` fields
- The `.gitignore` excludes `/public/` (build output) and `/resources/_gen/`
- Static assets (favicon, screenshots for blog posts) are in `static/`
- Custom layout override: `layouts/partials/head.html`

## Current Goals

- **Update CV**: Both `cv_fr.md` and `cv_en.md` are outdated (still say "étudiant en Master" and "alternance"). Need to reflect current CDI status at DataKhi (since 2025), including Nyukom and HUN projects.
- **Add new posts**: New articles that complement (not duplicate) the 5 articles published on the DataKhi blog (`https://www.datakhi.fr/fr/blog`).
- **Profile reference**: `tmp_profil.txt` contains a comprehensive profile analysis with project inventory, skills cartography, and career orientation - use it as source material for CV updates.

## DataKhi Blog Articles (by Nathan - DO NOT duplicate)

1. "Construire une plateforme de données souveraine" (jan 2026) - Architecture MinIO/PostgreSQL/Airflow/K3s
2. "Stockage de fichiers auto-hébergé : stockage objet et alternatives" (jan 2026) - S3, Garage, MinIO
3. "Passer à l'open source : comment ça se passe concrètement" (jan 2026) - Migration infra open source
4. "Anticiper l'affluence grâce au machine learning" (jan 2026) - XGBoost, prévision de demande
5. "Systèmes de recommandation : quelle architecture de BDD choisir" (jan 2026) - Graph DB vs Vector DB
