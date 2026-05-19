---
title: "Homepage : Un dashboard personnel avec Vue, Go et Canvas"
date: 2026-04-09
draft: false
tags: ["vue", "go", "canvas", "dashboard", "self-hosted", "homelab", "docker"]
description: "Conception d'un dashboard personnel avec horloge solaire animée, météo temps réel, todo board, agrégateur RSS, notes et pomodoro."
featureimage: "img/homepage.png"
---

Après avoir mis en place mon homelab et déployé pas mal de services dessus, il me manquait un truc tout bête : une page d'accueil. Pas un portail comme Homer ou Flame avec des icônes et des liens, mais quelque chose qui me donne envie de la garder ouverte en permanence — un outil de travail quotidien, pas juste un annuaire de services.

Le résultat est accessible à l'adresse [dashboard.spacesheep.ovh](https://dashboard.spacesheep.ovh/) et le code est sur mon [Gitea](https://git.spacesheep.ovh/nathanlq/homepage).

## L'idée

L'idée de base vient de [The Clock](https://blog.senko.net/the-clock) de Senko, une horloge solaire en canvas qui affiche l'heure sous forme de cercles concentriques avec la position du soleil. J'ai trouvé le concept tellement élégant que j'ai voulu m'en servir comme point de départ et construire un dashboard complet autour.

L'objectif était de combiner dans une seule page :
- Une visualisation du temps qui soit plus qu'un chiffre dans un coin
- De la météo temps réel intégrée directement dans l'horloge
- Un système de tâches avec une vue sur hier/aujourd'hui/demain
- Un agrégateur RSS pour ma veille tech
- Des notes éphémères pour les trucs qui ne méritent pas un fichier
- Un pomodoro pour les sessions de focus
- Un raccourci de recherche rapide (DuckDuckGo avec support des bangs)

Le tout sans framework CSS, sans lib de composants, sans dépendance superflue.

## Stack technique

La stack est volontairement minimale :

**Frontend** :
- [Vue 3](https://vuejs.org/) (Composition API) avec [Vite](https://vite.dev/)
- [Vue Router](https://router.vuejs.org/) pour le routing
- Canvas API pour l'horloge
- **Aucune autre dépendance** — pas de Tailwind, pas de Pinia, pas d'Axios

**Backend** :
- [Go](https://go.dev/) 1.23, **stdlib uniquement** — pas de framework, pas de routeur externe
- Stockage : un seul fichier JSON monté en volume Docker
- ~400 lignes pour toute l'API

**Infra** :
- Docker Compose (4 containers)
- Nginx pour servir le SPA
- [Miniflux](https://miniflux.app/) + PostgreSQL pour les flux RSS
- Images poussées sur mon registre Docker Gitea

## L'horloge

C'est le coeur visuel du dashboard. Un canvas plein écran qui dessine des cercles concentriques, du centre vers l'extérieur :

1. **Pression atmosphérique** — un cercle central dont le rayon varie avec la pression (970–1040 hPa)
2. **Secondes** — arc de progression sur 60 secondes
3. **Minutes** — arc de progression sur 60 minutes
4. **Heures** — arc de progression sur 24 heures, coloré selon l'heure solaire locale
5. **Météo 24h** — un anneau qui combine température (couleur de fond), couverture nuageuse (voile gris), précipitations (arc bleu extérieur) et rafales (arc intérieur avec gradient vert→orange→rouge)
6. **Fuseaux horaires** — un anneau rotatif avec des marqueurs pour Lille, Tokyo et New York, chacun coloré selon leur heure locale
7. **Année** — un cercle extérieur avec un marqueur pour le jour courant et des repères mensuels

La couleur de fond de toute la page change dynamiquement en fonction de l'élévation solaire calculée pour Lille (latitude 50.63°N). Le calcul utilise la déclinaison solaire et l'angle horaire pour déterminer la luminosité ambiante, ce qui donne une transition progressive entre le jour et la nuit.

Les données météo viennent de l'API [Open-Meteo](https://open-meteo.com/) (gratuite, sans clé API) et sont lissées avec une interpolation linéaire pour éviter les sauts visuels entre les rafraîchissements. Le canvas supporte aussi un mode de simulation temporelle : on peut naviguer dans le passé ou le futur et l'horloge va chercher les données historiques ou prévisionnelles correspondantes.

## Le backend Go

Le backend est un serveur HTTP en Go pur qui expose une API REST pour trois choses : les tâches, les notes éphémères, et un proxy RSS.

```go
mux.HandleFunc("/api/health", handleHealth)
mux.HandleFunc("/api/auth", handleAuth)
mux.HandleFunc("/api/tasks", requireAuth(handleTasks))
mux.HandleFunc("/api/tasks/", requireAuth(handleTask))
mux.HandleFunc("/api/notes", requireAuth(handleNotes))
mux.HandleFunc("/api/notes/", requireAuth(handleNote))
mux.HandleFunc("/api/rss", handleRSS)
```

L'authentification est simple : un token Bearer défini par variable d'environnement. Les endpoints privés (tâches, notes) le vérifient, le RSS et la météo restent publics.

Le stockage est un fichier JSON unique avec un mutex pour la concurrence. Pas de base de données — pour un dashboard mono-utilisateur, c'est largement suffisant et ça simplifie énormément le déploiement.

Un détail que j'aime bien : les tâches non terminées dont la date est dépassée sont automatiquement ramenées à aujourd'hui à chaque requête de listing. Ça évite d'avoir des tâches qui disparaissent dans le passé.

## Le todo board

Le todo board affiche trois colonnes : hier, aujourd'hui, demain. On peut naviguer dans le temps avec des flèches pour voir d'autres jours. Les tâches ont un titre, un champ de détails optionnel, une date et un statut (fait/pas fait).

L'ajout se fait inline en bas de chaque colonne — un simple champ texte avec un `+` comme placeholder. Pour les détails et la modification, un clic sur la tâche ouvre un panneau en overlay avec les champs éditables.

## L'agrégateur RSS

Plutôt que d'intégrer un lecteur RSS complet, j'ai choisi d'utiliser [Miniflux](https://miniflux.app/) comme backend RSS (il tourne déjà dans mon stack Docker Compose) et de parser les flux directement côté frontend via un proxy backend.

Le proxy est nécessaire pour contourner les restrictions CORS — le backend Go fetch le XML du flux, le renvoie tel quel, et le frontend le parse avec `DOMParser`. La liste des 17 flux suivis est déclarée dans un fichier JSON :

```json
[
  { "label": "zwindler", "url": "https://blog.zwindler.fr/index.xml" },
  { "label": "jvns", "url": "https://jvns.ca/atom.xml" },
  { "label": "momjian", "url": "https://momjian.us/main/rss/pgblog.xml" }
]
```

L'affichage est compact (10 articles) avec un mode étendu (40 articles) accessible via un bouton. Les timestamps sont affichés en relatif (3h, 1d, 2mo).

## Notes éphémères et pomodoro

Les notes éphémères sont un bloc simple : un champ de saisie, une liste de notes avec suppression. Maximum 50 notes stockées, les plus récentes en haut. C'est fait pour les choses qu'on griffonne sur un post-it et qu'on jette le lendemain.

Le pomodoro est minimal : 25 minutes de travail, 5 minutes de pause, clic pour pause/reprise, un bouton reset.

## Recherche rapide

`Ctrl+K` ouvre un overlay de recherche qui envoie la requête sur DuckDuckGo. Le support des bangs (`!g` pour Google, `!gh` pour GitHub, `!w` pour Wikipedia, etc.) est gratuit puisque c'est DuckDuckGo qui les gère.

## Déploiement

Le déploiement suit le même modèle que mes autres projets : des images Docker poussées sur mon registre Gitea, et un `docker-compose.yml` sur le serveur qui les tire.

```yaml
services:
  homepage:
    image: git.spacesheep.ovh/nathanlq/homepage:latest
    ports:
      - "18080:80"

  backend:
    image: git.spacesheep.ovh/nathanlq/homepage-backend:latest
    ports:
      - "18082:8080"
    environment:
      API_TOKEN: ${API_TOKEN}
    volumes:
      - backend-data:/data

  miniflux:
    image: miniflux/miniflux:latest
    depends_on:
      miniflux-db:
        condition: service_healthy
    # ...

  miniflux-db:
    image: postgres:16-alpine
    # ...
```

Un point important : `VITE_BACKEND_URL` est une variable de build (pas de runtime). Vite l'inline dans le bundle JavaScript au moment du `npm run build`. Il faut donc la passer en `--build-arg` au moment de construire l'image Docker, sinon le frontend essaiera de contacter `localhost:8082`.

Le tout est exposé derrière Nginx Proxy Manager avec des certificats Let's Encrypt.

## Ce que j'en retire

Ce projet m'a permis de toucher à pas mal de choses que je ne pratique pas forcément au quotidien dans mes missions data :
- Du **Canvas API** pur pour du rendu temps réel
- Du **Go sans framework** pour une API minimaliste
- Des **calculs astronomiques** (déclinaison solaire, angle horaire, élévation)
- Du **parsing XML côté client** pour les flux RSS

Le résultat est un outil que j'utilise vraiment tous les jours. C'est aussi un bon terrain de jeu pour expérimenter : ajouter un widget prend quelques minutes puisque tout est découplé en composables Vue indépendants.
