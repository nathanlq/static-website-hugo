---
title: "Book Reco : Génération de Vecteurs"
date: 2024-11-18
draft: false
tags: ["python", "microservices", "mlflow", "embedding", "books", "postgresql", "pgvector", "tfidf", "asyncpg"]
---

Dans le cadre de mon projet de recommandation de livres, un élément clé pour offrir des suggestions pertinentes repose sur la représentation vectorielle des données textuelles, comme les résumés et les titres des livres. Le module Vectorizer, développé en tant que microservice, est dédié à cette tâche.

Grâce à ce microservice, nous pouvons générer deux types de représentations vectorielles :

- **TF-IDF**, pour capturer l'importance des termes au sein des textes. Cela permettra d'entrainer des modèles pour labelliser rapidement les livres et les clusteriser dynamiquement dans un soucis de performance.
- **Embeddings réduits par PCA**, pour une représentation dense des contenus basée sur des modèles de type transformers. Cela permettra, combiné à des filtres, d'utiliser les moteur SQL pour générer les recommandations.

Ce module est conçu pour être intégré dans un pipeline d'analyse asynchrone et supervisé via **MLflow**, comme le bloc précédent. Tout est sur le dépôt [Github](https://github.com/nathanlq/book-reco).

## Structure du Projet

Voici un aperçu de la structure actuelle du module :

```bash
microservices/
├── readme.md
├── utils/
│   └── vectors.py
└── vectorizer.py
```

- **utils/vectors.py** : Contient la logique métier pour entraîner les modèles TF-IDF et PCA, ainsi que pour générer les vecteurs.
- **vectorizer.py** : Point d’entrée principal. Ce script gère l’asynchronisme avec asyncpg pour interagir avec la base PostgreSQL, tout en orchestrant les tâches d’initialisation, de calcul, et de surveillance des vecteurs.

## Fonctionnalités du Microservice

### 1. Initialisation des Modèles

#### Modèle PCA

La réduction dimensionnelle par PCA permet de transformer les embeddings produits par un modèle **CamemBERT** en vecteurs denses à 128 dimensions.

- **Source des données** : Les colonnes resume et product_title de la base de données PostgreSQL.
- **Tâches réalisées** :
    - Génération d’embeddings à partir des textes.
    - Entraînement d’un modèle PCA si aucun n’est disponible sur disque.
    - Versionnement du modèle avec MLflow.

```python
await initialize_pca_model(conn, table_name)
```

#### Modèle TF-IDF

Le modèle TF-IDF extrait les termes les plus importants dans les textes en tenant compte des stop words français. Une fois entraîné, il génère des vecteurs à 2048 dimensions.

- **Source des données** : Même source que le PCA.
- **Tâches réalisées** :
    - Construction du vocabulaire et entraînement à partir des données textuelles.
    - Versionnement avec MLflow.
    - Vérification du nombre de caractéristiques (2048 attendues).

```python
await initialize_tfidf_model(conn, table_name)
```

### 2. Génération de Vecteurs

Deux fonctions principales permettent de produire des représentations vectorielles à partir des données d’un livre.

#### Embeddings

Les embeddings sont générés en utilisant **CamemBERT** et réduits par PCA pour une utilisation plus efficace en base de données.

```python
def get_embedding(text, apply_pca=True):
    ...
```

#### TF-IDF

Un vecteur TF-IDF est généré en transformant les textes avec le modèle préalablement entraîné.


```python
def generate_tfidf_vector(column):
    ...
```

### 3. Mises à Jour des Vecteurs

Le script vectorizer.py met à jour les colonnes embedding et tfidf dans la base PostgreSQL :

- **Processus** :
    - Récupération des lignes où les colonnes vectorielles sont nulles.
    - Calcul des vecteurs et mise à jour par lots de 100 entrées.
    - Gestion des erreurs avec des mécanismes de reprise (**retry**).

### 4. Tâches Planifiées

Le microservice inclut deux tâches asynchrones pour garantir que les données vectorielles restent à jour :

- **Recalcul quotidien complet** :
    - Exécute une réinitialisation complète des modèles TF-IDF et PCA.
    - Recalcule les vecteurs pour l’ensemble des données.

```python
await daily_recalculation_task(conn, lock)
```

- **Surveillance périodique des nouvelles données** :
    - Détecte et traite les nouvelles entrées toutes les 5 minutes.

```python
await new_vector_watcher_task(conn, lock)
```

## Automatisation et Observabilité

### MLflow pour le Suivi des Modèles

Le module exploite **MLflow** pour :
- Versionner les modèles TF-IDF et PCA.
- Journaliser les paramètres (ex. : temps d’exécution, tailles des échantillons).
- Vérifier la reproductibilité des calculs.

### Gestion des Arrêts et Reprises

- Si une tâche échoue, le système réessaie jusqu’à 3 fois avant d’abandonner.
- Une logique de reconnexion est intégrée pour faire face aux déconnexions réseau avec PostgreSQL.

## Conclusion

Ce microservice constitue une brique importante pour générer des recommandations dans mon projet de suggestion de livres. Il repose sur des concepts modernes tels que les transformers, l’asynchronisme et le suivi des expériences, tout en restant extensible pour de futures optimisations.

Prochaine étape : faire une api qui utilise les fonctionnalités de pgvector et analyser la pertinence des recommandations générées.