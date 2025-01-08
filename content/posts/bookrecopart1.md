---
title: "Book Reco : Collecte de Données avec Scrapy"
date: 2024-10-24
draft: false
tags: ["python", "webscrapping", "scrapy", "automation", "books"]
---

Dans le cadre du projet de recommandation de livres, j’ai mis en place un premier module de collecte de données à l’aide de Scrapy. Cette étape est essentielle, car elle permet de récupérer les informations nécessaires depuis une librairie en ligne pour nourrir les futurs algorithmes de recommandation.

Ce projet est pensé pour évoluer. À terme, il s’agira d’une application complète de recommandation de livres, mais chaque étape est soigneusement construite pour être modulaire et extensible. Tout est sur le dépôt [Github](https://github.com/nathanlq/book-reco).

## Structure du Projet

Voici un aperçu de la structure actuelle du projet :

```bash
book_reco/
├── collect/
│   ├── furet_scraper/
│   │   ├── dupefilters/
│   │   ├── items.py
│   │   ├── middlewares.py
│   │   ├── pipelines.py
│   │   ├── settings.py
│   │   └── spiders/
│   └── scrapy.cfg
├── data/
│   └── raw_data.parquet
├── Makefile
├── requirements.txt
└── scripts/
    └── compress.py
```

Le cœur de ce module repose sur une spider Scrapy nommée furet_spider, qui scrute les pages de la section "meilleures ventes" de plusieurs catégories littéraires sur Furet.com.

## Scrapy : Collecte des Données

La spider explore plusieurs catégories de livres (romans, thrillers, science-fiction, etc.) et collecte pour chaque produit des informations telles que le titre, l'auteur, le résumé, les étiquettes et des métadonnées supplémentaires comme l'ISBN ou la couverture. Voici un extrait du code de la spider :

```python
class FuretSpider(scrapy.Spider):
    name = 'furet'
    start_urls = [
        'https://www.furet.com/livres/litterature/romans/meilleures-ventes.html',
        'https://www.furet.com/livres/litterature/policiers-et-thrillers/meilleures-ventes.html',
        ...
    ]

    def parse(self, response):
        product_url_pattern = re.compile(
            r'https://www\.furet\.com/livres/.*-\d+\.html$')
        links = response.css('a::attr(href)').getall()

        for link in links:
            absolute_link = response.urljoin(link)
            if product_url_pattern.match(absolute_link):
                yield scrapy.Request(absolute_link, callback=self.parse_product)

    def parse_product(self, response):
        product_title = response.css('h1.product-title::text').get()
        author = response.css('a.author::text').get()
        resume = response.css('div#resume div.content::text').get()

        if product_title and author:
            yield {
                'product_title': product_title.strip(),
                'author': author.strip(),
                'resume': resume.strip() if resume else '',
            }
```

Ce script est conçu pour ne pas collecter de doublons grâce à un mécanisme de filtrage des URLs déjà explorées.

## Transformation et Compression des Données

Une fois les données brutes extraites, elles sont sauvegardées au format JSON, puis compressées au format Parquet à l’aide d’un script Python simple :

```python
import pandas as pd

df = pd.read_json('data/raw_output.json')
df.to_parquet('data/raw_data.parquet')
```

L’intérêt ici est de faciliter la manipulation des données à grande échelle. Parquet permet des lectures rapides et efficaces, un atout non négligeable pour les prochaines étapes du projet, notamment l’analyse et l’entraînement d’algorithmes de recommandation.

## Automatisation avec Makefile

Pour automatiser le processus, un Makefile a été ajouté, permettant d’exécuter l’ensemble des tâches depuis un seul point d’entrée. Voici les cibles disponibles :

- setup : met en place l'environnement virtuel et installe les dépendances.
- run-scrapy : lance la collecte des données avec Scrapy.
- compress : compresse les données au format Parquet.
- clean : nettoie l'environnement et supprime les fichiers temporaires.

```Makefile
all: setup run-scrapy compress

setup:
	@echo "Setting up the environment..."
	$(PYTHON) -m venv venv
	. venv/bin/activate && pip install -r $(REQUIREMENTS)

run-scrapy:
	@echo "Running Scrapy spider..."
	. venv/bin/activate && cd $(PROJECT_DIR) && $(SCRAPY) crawl furet -o ../../$(DATA_DIR)/raw_output.json

compress:
	@echo "Compressing data..."
	. venv/bin/activate && $(PYTHON) $(SCRIPTS_DIR)/compress.py
```

Grâce à ce Makefile, l’ensemble du processus est simplifié : il suffit de lancer make all pour mettre en place l’environnement, exécuter la spider et compresser les données.

## Prochaines Étapes

Ce module de collecte de données est la première brique de mon projet de recommandation de livres. La suite va consister à enrichir ces données et à développer des algorithmes capables de recommander des livres en fonction des préférences utilisateurs, en utilisant des techniques de filtrage collaboratif et de traitement du langage naturel (NLP).