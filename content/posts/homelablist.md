---
title: "Liste des outils de mon homelab"
date: 2024-10-15
draft: false
tags: ["self-hosted", "homelab"]
---

Dans mon homelab, j'ai trois machines : mon routeur qui va se contenter d'avoir une IP fixe et de tout envoyer vers ma deuxième machine, un mini-PC qui me sert de serveur avec Nginx en point d'entrée pour dispatcher les requêtes entre lui-même et mon petit NAS Synology. Mon mini-PC a de la RAM et du CPU à foison, mon NAS juste de l'espace disque. J'ai donc choisi cette répartition de services :

## Serveur

### Reverse Proxy
- **[Nginx Proxy Manager](https://nginxproxymanager.com/)**  
  Outil simple d'utilisation pour gérer les redirections de proxy et les certificats SSL avec une interface web conviviale.

### Docker Monitoring
- **[Portainer](https://www.portainer.io/)**  
  Interface graphique puissante et intuitive pour gérer et surveiller les conteneurs Docker et les applications déployées.

### Password Manager
- **[Vaultwarden](https://noted.lol/vaultwarden/)**  
  Version légère et auto-hébergée de Bitwarden pour gérer de manière sécurisée vos mots de passe et autres informations sensibles.

### Redis
- **[Redis](https://redis.io/docs/latest/operate/oss_and_stack/install/install-stack/docker/)**  
  Système de base de données en mémoire clé-valeur open source, souvent utilisé pour le caching et la gestion de sessions.

### Blog
- **[Hugo + Hermit Theme](https://themes.gohugo.io/themes/hermit-v2/#sites-using-hermit-v2)**  
  Générateur de site statique ultra-rapide. Le thème "Hermit" propose un design minimaliste et épuré pour un blog personnel ou professionnel.

### Git
- **[Forgejo](https://forgejo.org/)**  
  Forge git auto-hébergée basée sur Gitea, permettant de gérer des dépôts Git, des issues, des pull requests, et des collaborations.

## NAS Synology

### Stockage

#### Container Registry
- **[Container Registry Synology](https://kb.synology.com/en-ca/DSM/help/ContainerManager/docker_desc?version=7)**  
  Gestion des images Docker localement sur le NAS, permettant un stockage centralisé des conteneurs.

#### FTP
- **[Synology FTP](https://kb.synology.com/fr-fr/DSM/tutorial/How_to_access_files_on_Synology_NAS_via_FTP)**  
  Permet de configurer et de gérer un serveur FTP pour un accès distant aux fichiers stockés sur le NAS.

#### PostgreSQL
- **[PostgreSQL sur Synology avec Container Manager](https://lofurol.fr/joomla/logiciels-libres/244-postgresql-installation-sur-un-nas-synology-avec-docker)**  
  Base de données relationnelle open-source, utilisée pour stocker des données d'applications web. Disponible avec pgvector.

#### Drive
- **[Synology Drive](https://kb.synology.com/fr-fr/DSM/help/SynologyDrive/drive_desc?version=7)**  
  Solution de synchronisation de fichiers pour remplacer Google Drive ou Dropbox avec une alternative auto-hébergée.

#### Notes / Todo List
- **[Note Station Synology](https://kb.synology.com/fr-fr/DSM/help/NoteStation/notestation_desc?version=7)**  
  Outil intégré pour prendre des notes, créer des listes de tâches, et organiser vos idées directement sur le NAS.

Cette configuration couvre tous mes besoins au quotidien et est largement scalable, les limites potentielles étant la RAM et le CPU de mon mini-PC qui limitent le nombre d'images Docker que je peux faire tourner, la disponibilité en bande passante de mon routeur, l'espace disque de mon NAS et, si j'abuse de pgvector, la RAM et le CPU de ce dernier (bien que j'aie déjà vu tourner des bases de données PostgreSQL sur des plus petites patates avec des performances plus qu'honnêtes). Pour la sécurité, je pourrais imaginer comme extension de mettre un [Wireguard](https://www.wireguard.com/) pour protéger certains services et un [Fail2Ban](https://github.com/fail2ban/fail2ban) pour filtrer les ips sur mon routeur qui possède une petite VM, ce qui me permettrait en plus d'alléger la charge réseau.