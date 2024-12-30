---
title: "Revue : Cloud Nord 2024 en diagonale"
date: 2024-10-11
draft: false
tags: ["greenit", "postgresql", "embedding", "vector", "architecture"]
---

J'ai été au salon de conférence [Cloud Nord](https://www.cloudnord.fr/) ce jeudi 10 Octobre 2024 et voici un retour pour attiser votre curiosité sur les talks qui m'ont le plus marqués.

## Impact Framework 

[Impact Framework](https://if.greensoftware.foundation/) est un outil de calcul de l'efficacité énergétique côté code, prenant en compte des aspects tels que l'empreinte computationnelle, la mémoire et le stockage par fournisseur. Il permet de générer des sorties en CSV, adaptables à divers outils, notamment un plugin Grafana. Cet outil est très utile pour optimiser la consommation énergétique des applications et contrôler les factures des cloud providers, les deux étant très corrélés.

>[Ludovic Dussart](https://www.linkedin.com/in/ludovic-dussart-846a8063) - [Zatsit](https://www.zatsit.fr/)

## Architecture de solution de Télémetrie Publicitaire

L'architecture de solution de télémetrie publicitaire présentée par Pubstack était très intéressante, avec des éléments tels que le wildcard et la base opérationnelle. Les points notables incluaient l'utilisation de Protobuf au lieu de JSON, la taille optimale des Parquet pour le wildcard, le passage de flux continu à batch, et la simplicité de maintenance. Ce cas d'école est très instructif et plein de retours d'expérience intéressants. Si vous devez ingérer plein de donnée et que vous ne voulez pas vous prendre la tête en maintenance de serveur, je vous conseille d'y jeter un oeil

> [Erwann Cloarec](https://www.linkedin.com/in/erwann-cloarec-354566a1) et [Valentin Maerten](https://vmaerten.io/a-propos/) - [Pubstack](https://www.pubstack.io/)

## Cloud Carbon

Encore une solution de monitoring d'impact écologique. [Cloud Carbon](https://www.cloudcarbonfootprint.org/) est une solution d'impact écologique basée sur les données de facturation des fournisseurs cloud. Elle est facile à mettre en place et se base sur la consommation effective, contrairement à l'Impact Framework qui est une prédiction. Cette solution est très simple à mettre en place et utile pour contrôler notre impact et nos dépenses sans prise de tête, juste en rangeant bien ses factures.

> [Emmanuel Peru](https://www.linkedin.com/in/emmanuel-peru-10111274/?originalSubdomain=fr) - [Zatsit](https://www.zatsit.fr/)

## Tri des Cartes Pokémon

La conférence sur le tri des cartes Pokémon présentait une architecture complète pour étiquetter des cartes pokemon en se basant sur la représentation vectorielle de ces dernières. Elle exposait aussi le fonctionnement de la recherche vectorielle dans PostGreSQL avec [pgvector](https://github.com/pgvector/pgvector). Les points notables incluaient l'importance de l'object detection, les opérateurs vectoriels de PostgreSQL, et les techniques de requêtage de proximité (KNN > HNSW > IVFF par ordre de rapidité décroissante). Si vous voulez apprendre à créer et ranger vos vecteurs ou que vous vous ennuyez et que vous cherchez des idées de projets sur votre temps libre, foncez.

> [Mathieu Cornillon]() - [Google](https://about.google/)

## Conclusion

Le salon Cloud Nord a été une excellente occasion de découvrir des outils et des architectures innovantes. Les présentations étaient riches en informations et en retours d'expérience, offrant des solutions pratiques et faciles à mettre en place. Si vous êtes de nature curieuse et que vous voulez remettre en cause votre façon de travailler ou juste apprendre plein de choses, assistez à ce genre d'evenement, vous y trouverez votre compte.

