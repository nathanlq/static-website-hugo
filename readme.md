# Blog Technique Homelab

## Présentation
Un blog technique généré de manière statique avec Hugo, conçu pour documenter et présenter les projets techniques personnels, les apprentissages et les réflexions sur le développement de l'infrastructure homelab.

## Fonctionnalités
- Génération de site statique avec Hugo
- Déploiement automatisé
- Contenu technique axé sur l'infrastructure, la programmation et les projets personnels
- Intégration avec l'infrastructure homelab

## Technologies
- Hugo (Générateur de site statique)
- Markdown
- Ansible pour le déploiement automatisé
- Nginx Proxy Manager pour un accès sécurisé

## Configuration de développement
1. Assurez-vous que Hugo est installé
2. Clonez le dépôt
3. Exécutez `hugo server` pour le développement local
4. Construisez avec `hugo`

## Déploiement
Déploiement automatisé géré par un playbook Ansible :
- Mises à jour automatiques des articles
- Sauvegardes programmées
- Accès HTTPS sécurisé via Nginx Proxy Manager

## Stratégie de contenu
- Tutoriels techniques
- Documentation de projets
- Réflexions sur l'infrastructure
- Notes d'exploration technologique
