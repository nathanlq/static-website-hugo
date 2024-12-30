---
title: "Book Reco : Serveur API"
date: 2024-11-19
draft: false
tags: ["python", "fastapi", "asyncpg", "postgresql", "api", "books", "microservices"]
---

Après avoir organisé les données en base, il s'agit maintenant de les exposer pour les futurs services. Le module "expose" est dédié à cette tâche. Il sert de serveur API pour requêter la base de données PostgreSQL et fournir des informations détaillées sur les livres ainsi que des recommandations basées sur des vecteurs. Tout est sur le dépôt [Github](https://github.com/nathanlq/book-reco).

Il permet de :
- **Récupérer des informations détaillées sur les livres** en utilisant divers filtres.
- **Générer des recommandations de livres similaires** en utilisant des méthodes de similarité vectorielle comme la distance euclidienne, la distance de Manhattan (taxicab) et la similarité cosinus.

Ce module est conçu pour être intégré dans un pipeline d'analyse asynchrone et supervisé via FastAPI, offrant une API RESTful performante et facile à utiliser.

## Structure du Projet

Voici un aperçu de la structure actuelle du module :

```bash
expose/
├── config.py
├── database.py
├── main.py
├── models.py
├── readme.md
└── routes.py
```

- **config.py** : Contient la configuration pour se connecter à la base de données PostgreSQL en utilisant des variables d'environnement.
- **database.py** : Gère la connexion asynchrone à la base de données PostgreSQL en utilisant asyncpg.
- **main.py** : Point d’entrée principal de l'application FastAPI.
- **models.py** : Définit le modèle de données pour les livres en utilisant Pydantic.
- **routes.py** : Contient les routes de l'API pour récupérer les informations des livres et générer des recommandations.


## Fonctionnalités du Microservice

### 1. Récupération des Informations des Livres

La route /books permet de récupérer des informations détaillées sur les livres en utilisant divers filtres.

- **Source des données** : La table de la base de données PostgreSQL spécifiée dans `TABLE_NAME`.
- **Filtres disponibles** : ID, titre du produit, auteur, résumé, URL de l'image, collection, date de parution, EAN, éditeur, format, ISBN, nombre de pages, poids, présentation, largeur, hauteur, profondeur.
- **Pagination** : Supporte la pagination avec les paramètres `page` et `page_size`.

```python
@router.get("/books", response_model=List[Book])
async def get_books(
    id: Optional[str] = Query(None, description="Filter by ID"),
    product_title: Optional[str] = Query(None, description="Filter by product title"),
    ...
    page: Optional[int] = Query(1, description="Page number"),
    page_size: Optional[int] = Query(10, description="Number of items per page")
):
    ...
```

### 2. Génération de Recommandations de Livres Similaires

La route `/books/{book_id}/similar` permet de générer des recommandations de livres similaires en utilisant des méthodes de similarité vectorielle.

- **Méthodes de similarité** : Euclidienne, Manhattan (taxicab), Cosinus.
- **Filtres disponibles** : Auteur, collection, éditeur, format.

```python
@router.get("/books/{book_id}/similar", response_model=List[Book])
async def get_similar_books(
    book_id: str,
    method: Optional[str] = Query("cosine", description="Method for finding similar books (taxicab, cosine, euclidean)"),
    author: Optional[bool] = Query(False, description="Filter by author"),
    ...
):
    ...
```

## Conclusion

Ce service permet d'interroger la base de données et de générer des recommandations dans mon projet de suggestion de livres. Il repose sur des concepts modernes tels que l'asynchronisme, tout en restant extensible pour de futures optimisations.