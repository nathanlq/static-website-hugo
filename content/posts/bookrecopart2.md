---
title: "Book Reco : Transformation et Stockage des Données"
date: 2024-11-17
draft: false
tags: ["python", "data", "mlflow", "automation", "books", "postgresql", "pgvector"]
---

Après avoir mis en place un module de collecte de données à l’aide de Scrapy, la prochaine étape de mon projet de recommandation de livres consiste à traiter, transformer et stocker les données. Cette étape repose sur le module **store**, qui organise les données collectées et les prépare pour les prochaines phases d’analyse et de modélisation. Tout est sur le dépôt [Github](https://github.com/nathanlq/book-reco).

En plus d’optimiser les données, ce module intègre **MLflow** pour suivre et documenter chaque étape du pipeline, garantissant une traçabilité et une reproductibilité complètes. Je ne vais pas détailler son utilisation dans cette article, un post sera dédié à ce service qui permet à la fois de monitorer et de versionner le service pour empêcher la dérive des modéles ou leur régression potentielle.

## Structure du Projet

Voici un aperçu de la structure actuelle du module :

```bash
book_reco/
├── store/
│   ├── compress.py
│   ├── prepare.py
│   ├── loader.py
└── mlruns/
```

Le module est organisé en trois scripts principaux :

- **`compress.py`** : Convertit les données brutes en un format optimisé pour le stockage.
- **`prepare.py`** : Nettoie et transforme les données pour une exploitation future.
- **`loader.py`** : Charge les données dans une base PostgreSQL.

## Transformation et Compression des Données

### Compression avec `compress.py`

Le script `compress.py` constitue le premier maillon du pipeline. Il lit les données JSON extraites lors de la phase de collecte et les compresse en format **Parquet**, pour que la lecture et l'écriture soit plus rapide. En plus, si la quantité de données devient trop grande, on pourra imaginer le lire avec pyspark pour ne pas avoir à tout charger en mémoire.

#### Fonctionnement :
- **Entrée** : `data/raw_output.json`
- **Sortie** : `data/raw_data.parquet`

Le script utilise la bibliothèque `pandas` pour effectuer cette transformation et enregistre également des informations importantes via MLflow, comme le nombre de lignes traitées et les chemins des fichiers en entrée et en sortie. Pour l'instant, c'est trivial mais on pourra imaginer plus tard y mettre du code en plus si l'on rencontre des problèmes d'encodage ou de parsing.

### Préparation avec `prepare.py`

Une fois les données compressées, le script `prepare.py` se charge d’un traitement approfondi pour assurer leur qualité et leur cohérence. Il comprend :

- **Nettoyage des étiquettes** : Les colonnes contenant des étiquettes sont normalisées et les termes inutiles (stop words) sont supprimés.
- **Extraction des métadonnées** : Des champs comme l’ISBN, les dimensions et les dates de publication sont extraits et restructurés.
- **Encodage catégoriel** : Les colonnes comme l’auteur ou l’éditeur sont transformées en types catégoriels, facilitant leur utilisation dans des modèles de machine learning.
- **Conversion de types** : Les dates et dimensions (largeur, hauteur, profondeur) sont converties en types appropriés.

#### Fonctionnement :
- **Entrée** : `data/raw_data.parquet`
- **Sortie** : `data/cleaned_data.parquet`

## Chargement avec `loader.py`

Le script final, `loader.py`, charge les données nettoyées dans une base de données PostgreSQL. Il s’appuie sur des fonctionnalités avancées pour garantir la qualité et l’intégrité des données :

- **Génération d’identifiants uniques** : Création d’un id basé sur une combinaison de métadonnées comme le titre et l’auteur.
- **Support JSONB** : Les colonnes contenant des données non structurées, comme "labels", sont enregistrées au format JSONB.
- **Extension vectorielle** : Intégration des colonnes embedding et tfidf pour les recherches avancées.

### Fonctionnement:

- **Entrée** : data/cleaned_data.parquet
- **Base de données cible** : PostgreSQL

### Schéma de la Base :

```json
{
    "columns": [
        {"name": "id", "type": "TEXT PRIMARY KEY"},
        {"name": "product_title", "type": "TEXT"},
        {"name": "author", "type": "TEXT"},
        {"name": "resume", "type": "TEXT"},
        {"name": "labels", "type": "JSONB"},
        {"name": "date_de_parution", "type": "DATE"},
        {"name": "ean", "type": "BIGINT"},
        {"name": "nb_de_pages", "type": "INT"},
        {"name": "poids", "type": "DECIMAL(5, 3)"},
        {"name": "width", "type": "DECIMAL(5, 2)"},
        {"name": "height", "type": "DECIMAL(5, 2)"},
        {"name": "depth", "type": "DECIMAL(5, 2)"},
        {"name": "embedding", "type": "VECTOR(128)"},
        {"name": "tfidf", "type": "VECTOR(2048)"}
    ]
}
```

Une fois les données chargées en base le plus rapidement possible, je délègue à des microservices le soin de les labelliser et de calculer les différentes colonnes utiles pour la recommandation.

## Traçabilité avec MLflow

MLflow est utilisé dans ce module, fournissant une visibilité complète sur le pipeline :

- **Paramètres et Métriques** : Suivi des fichiers traités, des tailles des jeux de données et des étapes d’exécution.
- **Artefacts** : Stockage des fichiers Parquet intermédiaires pour future inspection. Le modèle de `prepare` avec signature est aussi sauvegardé.
- **Expériences partagées** : Les scripts `compress.py`, `prepare.py` et `loader.py` enregistrent leurs runs dans une expérience commune appelée `compress_prepare_load`.

```python
with mlflow.start_run(run_name="prepare_run"):
    mlflow.log_param("input_file", "data/raw_data.parquet")
    mlflow.log_param("output_file", "data/cleaned_data.parquet")
    mlflow.log_metric("rows_processed", prepared_df.shape[0])
    mlflow.log_artifact("data/cleaned_data.parquet")
```

## Conclusion

Cette étape de transformation et stockage des données pose les bases d’un pipeline robuste, prêt à alimenter les algorithmes de recommandation. Dans les prochains articles, nous explorerons l’utilisation de MLflow pour le suivi des modèles et l’intégration des microservices pour enrichir les données en temps réel.