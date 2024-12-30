---
title: "Book Reco : Architecture cible"
date: 2024-10-22
draft: false
tags: ["modularity", "scalability", "automation", "architecture"]
---

Pour consolider mes compétences en développement, je me suis lancé dans un projet de recommandation de livres. Mon objectif est de concevoir une architecture simple mais modulable, capable de gérer la scalabilité et de rester disponible en continu. Ce projet inclut des phases de collecte de données, de labellisation et de vectorisation, ce qui me permet d’explorer l’ensemble de la stack logicielle, d’utiliser les bibliothèques standard et d’héberger le tout dans mon homelab.

## Architecture

Voici l’architecture envisagée pour ce projet :

![architecture](https://i.ibb.co/G7HYKcL/BigData.png)

L'architecture repose sur trois couches : la collecte de données, leur traitement, et enfin l’application qui exposera ces données.

### Collecte des données

L'idée est d'utiliser **Scrapy** pour extraire des données depuis un ou plusieurs sites, en les cartographiant. L'objectif est de récupérer les URLs en les liant entre elles pour former un graphe structuré du site. Cela permet de filtrer les contenus non pertinents et d’optimiser le temps de collecte en conservant uniquement le sous-graphe des pages d'intérêt (on peut par exemple exclure les sections non pertinentes pour éviter les branches inutiles).

Une fois les URLs identifiées, on les transmet aux scrappeurs pour extraire le contenu nécessaire. Pour les sites riches en JavaScript, l’utilisation de bibliothèques comme **Pyppeteer** ou **Selenium** permet de charger dynamiquement les sections HTML souhaitées.

Dans notre cas, la source principale, le site du Furet du Nord, ne nécessite pas de chargement JS. Cela simplifie le processus : une brique unique peut réaliser le crawling et le scraping sans nécessiter la création d’un graphe complexe. La collecte est donc rapide et efficace.

Les données sont stockées en sortie sous forme de fichiers **Parquet** horodatés, un format optimisé pour réduire leur taille et faciliter les requêtes, notamment avec des recherches de type wildcard. Ce processus peut être automatisé via un cron hebdomadaire.

### Traitement des données

Une fois les données brutes collectées, vient l’étape de leur traitement et de leur organisation. L’objectif est de créer un moteur de recherche et de recommandation, ce qui nécessite la labellisation et la vectorisation des données. Deux sous-systèmes ont été définis pour cette étape :

1. **Labelizer** : cette brique se charge de labelliser et segmenter les données. Elle pourrait même intégrer un modèle de classification pour une catégorisation plus poussée, en utilisant des méthodes légères de type **bag-of-words** pour limiter l’impact sur les ressources. Elle s’active automatiquement à chaque nouveau batch de données. Les modèles de labellisation, mis à jour périodiquement, sont stockés sous forme de fichiers .pkl.

2. **Vectorizer** : cette brique gère la vectorisation en générant des embeddings qui représentent les informations sémantiques des résumés. **Pgvector** est utilisé pour le requêtage vectoriel. Ce microservice reste actif pour éviter de recharger le modèle à chaque requête et s’adapte aux nouvelles données grâce à un finetuning mensuel. Si le maintenir actif en permanence est un luxe, on peut le lancer sur demande, en parallèle de Labelizer, bien que cela réduise la réactivité du système.

La labellisation et la vectorisation structurent ainsi les données, optimisant les requêtes pour un temps de réponse rapide et des résultats pertinents, même sur des configurations matérielles modestes.

### Exposition des données

Rien de plus simple, une API qui se branche sur notre base, une application L’exposition des données est simplifiée par une API qui se connecte directement à la base de données. L'application frontale s'appuie sur cette API pour afficher les résultats de manière claire et attrayante, permettant une interaction utilisateur fluide et agréable.

L'API, construite avec **FastApi**, propose une requête de recommandation paramétrable et pondérée pour mieux refléter les préférences de lecture de chaque utilisateur. Cette API gère les points suivants :

1. **Personnalisation pondérée** : la recommandation peut être paramétrée en fonction des préférences de l'utilisateur, avec une pondération basée sur les appréciations passées. Les utilisateurs peuvent noter chaque livre lu avec une intensité de satisfaction (par exemple, "fortement apprécié", "moyennement apprécié" ou "pas du tout apprécié"). Ces notes influencent les suggestions en donnant plus de poids aux lectures très appréciées et moins de poids aux autres, améliorant ainsi la pertinence des recommandations.

2. **Endpoints de gestion de la bibliothèque** : l’API permet à l'utilisateur d'ajouter ou modifier les appréciations de ses livres. À chaque ajout ou modification, la pondération des recommandations est ajustée pour mieux correspondre à ses goûts évolutifs.

Sur le front-end, développé avec **Vue.js** ou **React** en **TypeScript** et construit avec **Vite**, l’application intègre des fonctionnalités avancées de gestion des recommandations :

1. **Notation des livres** : dans sa bibliothèque personnelle, l'utilisateur peut noter chaque livre en sélectionnant un niveau d'appréciation. Cette notation est ensuite utilisée pour pondérer les prochaines recommandations.

2. **Personnalisation des recommandations** : l’utilisateur peut ajuster les suggestions en fonction de ses préférences. Par exemple, une interface pourrait permettre d’accorder plus de poids aux genres ou aux styles qu'il a appréciés, ou de limiter les suggestions de types de livres moins appréciés. La pondération est gérée en amont par l'API, qui intègre ce feedback dans les algorithmes de recommandation.

3. **Affichage dynamique des recommandations** : chaque fois que l'utilisateur modifie une appréciation ou qu’il consulte ses recommandations, les résultats sont mis à jour en temps réel pour refléter ses goûts.

Grâce à cette architecture, l'application est rapide, réactive et surtout personnalisée, fournissant des recommandations de lecture optimisées pour chaque utilisateur.