---
title: "Recherche : Modèles, algorithmes et logiciels pour l'harmonisation de mélodies"
date: 2024-10-23
draft: false
tags: ["harmonisation", "algorithms", "music", "AI"]
---

L'harmonisation de mélodies est un domaine d'étude fascinant, combinant musique et algorithmes pour générer des accords à partir de simples lignes mélodiques. Mon travail de recherche se concentre sur les techniques actuelles, en particulier celles ne nécessitant pas d'entraînement préalable. L'objectif est de comprendre comment des méthodes innovantes s'affranchissent des modèles complexes pour proposer des solutions efficaces à ce problème classique. Toutes le détail des sources, les articles de références et les documents complets se trouvent sur ce [Github](https://github.com/nathanlq/melody-harmony).

## Pourquoi cette étude ?

Les recherches en harmonisation automatique se sont largement développées ces dernières années, mais une grande partie des techniques repose sur des modèles complexes comme l'apprentissage profond. Dans ce projet, je me suis intéressé aux méthodes qui ne nécessitent pas cet entraînement préalable, offrant ainsi une alternative plus accessible et flexible. Ma démarche consiste à effectuer une revue de l’état de l’art et à proposer une analyse comparative des différentes approches.

## Démarche adoptée

Le processus de recherche a commencé par une étude approfondie des publications récentes. Les articles sélectionnés couvrent un large éventail de techniques allant des algorithmes probabilistes à la modélisation par vecteurs de contexte de hauteur, en passant par des structures d’arbres hiérarchiques.

Pour chaque méthode, j'ai synthétisé les principes fondamentaux et analysé les résultats obtenus. L'objectif est de comparer leur efficacité et leurs limitations dans un contexte où les ressources et l'accès aux données pour l'apprentissage sont restreints.

## Grille d'analyse

Les cinq articles principaux étudiés dans cette analyse couvrent des approches variées. Voici un aperçu des points clés examinés :

1. **Automatic Melodic Harmonization** : Cet article propose une vue d’ensemble des techniques d’harmonisation et identifie deux grandes approches : la génération d’accords pour une mélodie soprano et l’harmonisation à partir d’une ligne de basse.

2. **Algorithmic Harmonization of Tonal Melodies Using Weighted Pitch Context Vectors** : Sans nécessiter d’apprentissage préalable, cette méthode utilise des vecteurs de contexte de hauteur pour produire des accords à partir d'une mélodie, offrant ainsi une harmonisation dynamique.

3. **Melody Harmonization With Interpolated Probabilistic Models** : En combinant plusieurs modèles probabilistes, cette approche cherche à prédire les progressions d’accords les plus probables, avec une précision accrue de 5% par rapport aux méthodes basées sur des règles.

4. **Function- and rhythm-aware melody harmonization based on tree-structured parsing** : Ici, l’accent est mis sur la structure rythmique et les fonctions harmoniques grâce à une modélisation hiérarchique sous forme d’arbre.

5. **Automatic Melody Harmonization with Triad Chords** : Cet article compare diverses méthodes d’harmonisation, incluant les HMM, les algorithmes génétiques, et les modèles d’apprentissage profond, en montrant une supériorité des méthodes basées sur le deep learning.

## Grille d’analyse

Figure A.1 – Analyse comparative des techniques d’harmonisation mélodique.

![analysis-grid](https://i.ibb.co/Vp19pvr/analysis-grid.png)

## Conclusion

Cette étude a permis de mettre en lumière les techniques d’harmonisation les plus prometteuses, tout en identifiant les limites des approches traditionnelles. Les méthodes sans apprentissage préalable, bien que moins flexibles que les approches complexes, montrent un potentiel important dans certains contextes.

Pour une comparaison plus détaillée des résultats et des performances de chaque méthode, une analyse approfondie peut être trouvée dans la grille d'analyse du projet.