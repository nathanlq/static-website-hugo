---
title: "Web : Faire un site statique avec Hugo"
date: 2024-09-24
draft: false
tags: ["blog", "static-website-generator", "hugo", "portfolio"]
---

Ce site est une vitrine pour exposer ce que je fais sur mon temps libre et m'entraîner à la rédaction d'articles pour améliorer ma vulgarisation technique. C'est aussi un excellent support pour me motiver à sortir de gestation l'énorme quantité d'idées de projets qui traînent dans mes backlogs. La veille technologique étant le nerf non pas de la guerre mais de l'efficacité, j'espère que ce portfolio facile à maintenir m'aidera à y consacrer plus de temps.

Toute la structure de ce blog est faite avec [Hugo](https://gohugo.io/), un framework pour construire très vite des sites web pour ceux qui n'aiment pas passer des heures à écraser des règles CSS pour rendre un texte un peu plus contrasté et le décaler de 2 pixels vers la droite sans casser tout le reste du site en gardant la responsivité. Vous pouvez consulter tout le code de ce site sur ce dépôt [Github](https://github.com/nathanlq/static-website-hugo).

## Initialisation

Pour le créer, rien de plus simple, il suffit d'installer ce truc sur sa machine. Si vous êtes comme moi sur une base Debian, c'est dans les dépôts officiels :

```bash
apt install hugo
```

Puis de créer un template de site statique et de rentrer dedans avec cette commande :

```bash
hugo new site site_statique_genial
cd site_statique_genial
```

Pour lancer le site en mode développement, c'est la commande :

```bash
hugo server -D
```

## Configuration

Et à partir de là, pour avoir autre chose qu'une page blanche, il faut installer un [thème](https://thèmes.gohugo.io/thèmes/), de mon coté il s'agit de [Hermit V2](https://thèmes.gohugo.io/thèmes/hermit-v2/) qui s'installe simplement avec:

```bash
git clone https://github.com/1bl4z3r/hermit-V2 thèmes/hermit-v2
```

Vous avez normalement alors dans le dossier *themes* l'ensemble des thèmes téléchargés. Ils ont normalement tous la même structure, avec un fichier *hugo.toml.example*. Pour paramétrer votre site, copiez le contenu de ce fichier dans *config.toml* à la racine de votre site et vous pouvez tout paramétrer facilement dedans.

Le contenu de votre site doit se trouver dans le dossier content, et vous pouvez le mettre directement en fichier *markdown* et il sera servi bien comme il faut. Voilà mon exemple de structuration minimal à la fin de *config.toml* :

```toml
...
[menu]

  [[menu.main]]
    name = "Projets"
    url = "posts/"
    weight = 10

  [[menu.main]]
    name = "À propos"
    url = "about-spacesheep"
    weight = 20

  [[menu.main]]
    name = "Curriculum Vitae"
    url = "cv"
    weight = 20
```

Et cela me donne ce dossier *content* :

```bash
content/
├── about-spacesheep.md
├── cv.md
└── posts
    ├── article1.md
    └── article2.md
```

## Customisation

Tout le dossier *layouts* du thème peut être modifié. Il est écrasé par le dossier *layouts* de la racine. Par exemple, pour ajouter une favicon, je dois créer un fichier *layouts/partials/head.html* et mettre dedans :

```html
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<link rel="shortcut icon" href="/favicon.ico">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="thème-color" content="#ffffff">
```

Les fichiers pour être accessibles doivent être situés dans le dossier *static* :


```bash
static/
├── android-chrome-192x192.png
├── android-chrome-512x512.png
├── apple-touch-icon.png
├── favicon-16x16.png
├── favicon-32x32.png
├── favicon.ico
└── site.webmanifest
```

À partir de là, vous pouvez à peu près modifier tout tant que le thème vous le permet, et s'il vous manque des choses, vous pouvez aller jusqu'à créer votre propre thème.

## Déploiement

On construit le dossier public pouvant être servi avec la commande :

```bash
hugo
```

Et il suffit ensuite de transférer le contenu de ce dossier sur le serveur de votre choix avec votre client FTP préféré.

## Liens Utiles

- [Hugo](https://gohugo.io/)
- [Listes non exhaustives de générateur de sites](https://jamstack.org/generators/)
- [Le thème utilisé sur ce site](https://themes.gohugo.io/themes/hermit-v2/)