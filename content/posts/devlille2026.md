---
title: "Retour : mon premier talk au DevLille 2026 (souveraineté data)"
date: 2026-06-29
draft: true
tags: ["souveraineté", "devlille", "conférence", "mlops", "self-hosted", "data"]
description: "Retour d'expérience sur mon premier talk en conférence : souveraineté data au DevLille 2026, les ressources, et ce que les questions du public m'ont appris."
featureimage: "img/devlille-2026.jpg"
---

Le 12 juin 2026, je suis monté sur la scène du Grand Théâtre du DevLille, en duo avec [Jonathan Fritsch](https://www.linkedin.com/in/jonathan-fritsch/), pour un talk intitulé *« Reprenez le contrôle de votre plateforme data face aux géants américains »*. C'était mon **premier talk en conférence**, et plutôt que d'en refaire le déroulé ici, je préfère poser deux choses : les **ressources** pour celles et ceux qui veulent creuser, et un **retour honnête** sur ce que l'exercice m'a appris.

![Sur scène au DevLille 2026](/img/devlille-2026.jpg)

## Le message, en une phrase

L'idée du talk tient en une ligne : reprendre le contrôle de sa plateforme data, ce n'est pas « tout rapatrier » d'un bloc, c'est **diversifier ses dépendances critiques brique par brique** — remettre les briques les plus sensibles (stockage, orchestration, modèles) sur des fondations qu'on maîtrise, avec de l'open-source opérable par une équipe normale (MinIO, PostgreSQL, Airflow, Kubernetes), sans exploser ni les coûts ni l'équipe.

Voilà pour le fond. Le reste de cet article, c'est ce qu'il y a *autour* du talk.

## Les ressources

Plutôt que de paraphraser les slides, voici de quoi aller plus loin par vous-mêmes :

- **Les slides** : [lien à venir]
- **L'article DataKhi sur la plateforme data souveraine** — la stack MinIO / PostgreSQL / Airflow / K3s, le socle du talk : [blog DataKhi](https://www.datakhi.fr/fr/blog)
- **L'article DataKhi sur le stockage objet auto-hébergé** — S3, Garage, MinIO : où chacun a sa place : [blog DataKhi](https://www.datakhi.fr/fr/blog)
- **Les briques open-source** : [MinIO](https://min.io/), [Garage](https://garagehq.deuxfleurs.fr/) (S3 européen), [PostgreSQL](https://www.postgresql.org/), [Apache Airflow](https://airflow.apache.org/), [K3s](https://k3s.io/)

La partie stockage s'appuie sur un **benchmark Garage vs MinIO** (cluster 3 nœuds et mono-nœud, lectures DuckDB sur parquet, écritures boto3, test de résilience avec coupure de nœud) qui a servi de fondation technique au talk. C'est typiquement le genre de « mesurer plutôt que deviner » qui rend le discours souverain crédible : on ne dit pas « c'est faisable », on montre les chiffres.

## Le retour à chaud

Premier talk, et en duo : honnêtement, c'était cool. Monter sur une grande scène, c'est moins intimidant que prévu une fois qu'on est lancé — le duo aide beaucoup, on se passe la balle, il y a toujours quelqu'un pour rebondir. La préparation est l'essentiel du travail ; le jour J, si le fil est clair, ça se déroule tout seul.

Mais le plus instructif n'a pas été le talk lui-même. Ça a été les **questions**.

## Ce que les questions m'ont appris

Le sujet de fond du talk, c'était la **souveraineté**. Or les questions, elles, n'ont quasiment pas porté là-dessus. Elles ont tourné autour d'**une seule chose : le coût**. Combien ça coûte de faire tourner ça soi-même ? Et surtout, comment ça se compare au **coût du cloud européen** ?

C'est le retour le plus précieux de la journée : **le frein perçu n'est pas la souveraineté, c'est le coût.** Les gens ne se demandent pas « est-ce que c'est souverain » ou « est-ce que je sais le faire » — ils se demandent « est-ce que je peux me le permettre ». Le vrai débat est économique, pas technique.

## Ce que je referais différemment

Si je redonnais ce talk demain, à la lumière de ces retours :

- Je **détaillerais les coûts marginaux**. La bonne question n'est pas « combien coûte une plateforme self-host complète » mais « combien coûte *en plus* le fait d'ajouter une brique souveraine à côté de l'existant ». C'est ce coût marginal qui décide, et c'est lui qu'il faut chiffrer.
- Je **passerais plus de temps sur les coûts européens**, puisque c'est là que la salle avait envie d'aller.
- Et surtout, je **démystifierais la mise en place**. Parce qu'il y a un malentendu à lever : la souveraineté, le self-host, **c'est plus facile à monter qu'on ne le croit**. Ce n'est pas un chantier pharaonique. Brique par brique, avec de l'open-source mûr, une équipe normale y arrive. Le vrai sujet à traiter en priorité, ce n'est donc pas la faisabilité — c'est le coût. Et ça, ça mérite un contenu à part entière.

C'est probablement la direction de mes prochains écrits : **démonter, chiffres à l'appui, l'idée que reprendre le contrôle coûte forcément cher.**

## La suite

L'aventure « scène » ne s'arrête pas là. J'ai proposé un talk au **meetup PostgreSQL de Lille, à la rentrée de septembre 2026** — un REX technique sur le moteur de recommandation de [Tossée](https://github.com/datakhi/tossee), qui est passé d'un couplage base graphe / MongoDB vers **pgvector** :

> **« Recommandez-moi une base de données (avant que mon catalogue ne le fasse tout seul) »**
> Reco produit à la volée dans PostgreSQL avec pgvector — sans base vectorielle dédiée.

Au programme : pourquoi l'approche graphe précalculée explose en N², le retournement vectoriel (stocker les positions plutôt que les relations), la recherche hybride (filtres SQL + `ORDER BY` vectoriel dans une seule base ACID), le choix de la distance et de l'index (IVFFlat vs HNSW), et deux astuces pour **stabiliser le temps d'exécution** (échantillonnage par plage) et **la pertinence** (scoring composite SQL). Avec un petit code Python minimaliste pour que vous puissiez reproduire.

Le sujet est creusé dans cet [article DataKhi sur les architectures de bases de données pour la recommandation](https://datakhi.fr/fr/blog/systemes-recommandation-architecture-base-donnees-2025).

Si pgvector, la reco ou la souveraineté data vous parlent, on se croisera sûrement par là. La conversation continue.
