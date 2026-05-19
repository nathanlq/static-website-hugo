# TODO — Blog Hugo

Ce TODO se limite à ce qui est spécifique au repo blog. Le **plan opérationnel d'articles** (cadence, sujets, promotion, canaux) vit dans `~/Documents/perso/TODO.md` — direction MLOps frugal et souverain.

Le **catalogue d'idées d'articles** (filtré sur la niche actuelle) est dans `propositions-articles.md`.

---

## Actions immédiates sur le site

- [ ] **Photo de profil** — portrait net dans `assets/`, configurer `params.author.image` dans `config/_default/languages.fr.toml`.
- [x] ~~CV à jour~~ — `cv_fr.md` + `cv_en.md` refondus (positionnement MLOps, talk DevLille, drive-knowledge-mcp + SIRENE + Benchmark Garage ajoutés, Tossée mis en avant pour l'écoconception). À relire pour vérifier les dates précises et l'exactitude factuelle.
- [ ] **Migrer les CV vers Reactive Resume** — voir `~/Documents/perso/TODO.md` Bloc 1. Une fois Reactive Resume installé sur k3s, importer le contenu des markdown actuels, générer les PDFs depuis l'UI, updater les liens dans `content/about.md` et le menu Hugo, puis supprimer `cv_fr.md` / `cv_en.md` + la cible `make build` PDF.
- [ ] **Liens DataKhi blog** — remplacer les liens génériques par les URLs directes de chaque article dans `content/projets.md` et autres.
- [ ] **Mobile** — vérifier le rendu responsive avant prochain deploy.
- [ ] **Lien Mastodon** — quand le compte sera créé (cf. TODO racine), l'ajouter dans `config/_default/languages.fr.toml` à côté de LinkedIn et GitHub.
- [ ] **URL LinkedIn** — quand la vanity URL aura été changée (cf. TODO racine, section LinkedIn minimal), mettre à jour `content/about.md` et la config.

## Couvertures d'articles

Voir `~/Documents/perso/TODO-blog-covers.md` pour le projet de générateur algorithmique de covers (typo/icône habitée par flow fields, paramétrée par embedding du post). C'est l'approche choisie au lieu de stock photo / IA bloated.

En attendant que le générateur soit prêt : on peut ajouter des featured images simples (un schéma drawio, un screenshot Grafana, etc.) pour les articles publiés au cas par cas, mais ce n'est plus un chantier dédié — le générateur prendra le relais.

## Build et deploy

```bash
hugo server          # dev local
make build           # génère les PDFs CV puis hugo build
# Deploy via Ansible playbook sur le serveur (cf. infra-homelab)
```

Pré-requis fresh clone : `git submodule update --init --recursive` (theme hermit-v2).

## Conventions à respecter

- Frontmatter posts : `title`, `date`, `draft`, `tags`, `description` (cf. articles existants pour les valeurs typiques de tags).
- Pas de doublon avec les 5 articles déjà publiés sur le blog DataKhi (liste dans `CLAUDE.md`).
- Pages CV (`cv_fr.md`, `cv_en.md`) sans frontmatter Hugo.
