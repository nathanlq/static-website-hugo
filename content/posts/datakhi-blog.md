---
title: "Ce que je publie sur le blog DataKhi"
date: "2026-02-13"
draft: false
tags: ["datakhi", "data-engineering", "machine-learning", "open-source"]
description: "Présentation des 5 articles techniques que j'ai écrits sur le blog de DataKhi en 2026."
---

Depuis début 2026, je publie des articles techniques sur le [blog de DataKhi](https://www.datakhi.fr/fr/blog), le cabinet de conseil data où je travaille en CDI depuis 2025. Ces articles sont issus de problèmes concrets rencontrés en mission — pas de la théorie, du retour d'expérience.

Je ne vais pas les résumer ici (ils sont déjà écrits et accessibles), juste donner le contexte dans lequel chacun a été rédigé.

---

## Les articles

### [Construire une plateforme de données souveraine](https://www.datakhi.fr/fr/blog)

Écrit après avoir déployé une plateforme data complète pour un client télécom (mission Nyukom). L'article couvre l'architecture MinIO / PostgreSQL / Airflow / K3s et les choix techniques qui ont mené à une stack 100% open source et auto-hébergeable. C'est le retour d'expérience le plus complet que j'ai écrit à ce jour.

### [Stockage de fichiers auto-hébergé : stockage objet et alternatives](https://www.datakhi.fr/fr/blog)

Un comparatif pragmatique des solutions de stockage objet compatibles S3 (MinIO, Garage, et le protocole S3 en général). Écrit parce que le choix du stockage objet est un des premiers qu'on fait quand on monte une plateforme data, et que la documentation existante est souvent orientée cloud public.

### [Passer à l'open source : comment ça se passe concrètement](https://www.datakhi.fr/fr/blog)

Le pendant "non technique" des deux articles précédents. Comment on aborde une migration vers l'open source avec un client qui n'est pas technique, les freins, les arguments, ce que ça change au quotidien. J'ai voulu écrire quelque chose de lisible par des décideurs, pas que par des ingénieurs.

### [Anticiper l'affluence grâce au machine learning](https://www.datakhi.fr/fr/blog)

Issu de la mission Hall U Need, sur laquelle je travaille depuis mon alternance. On prédit le nombre de couverts par jour dans des restaurants avec du XGBoost quantile. L'article détaille le feature engineering (météo, calendrier, jours fériés, réservations) et les choix de modélisation.

### [Systèmes de recommandation : quelle architecture de BDD choisir](https://www.datakhi.fr/fr/blog)

Un comparatif Graph DB vs Vector DB pour les systèmes de recommandation, avec PostgreSQL/pgvector comme fil rouge. Écrit en croisant l'expérience du projet Tossée (recommandation de produits mode) et du projet personnel Book Reco (recommandation de livres).

---

Les articles sont tous disponibles sur [https://www.datakhi.fr/fr/blog](https://www.datakhi.fr/fr/blog).
