---
title: "Homelab : Exposition des Services et Automatisation"
date: 2025-01-05
draft: false
tags: ["ansible", "nginx", "automation", "homelab", "docker", "https"]
---

Après avoir mis en place l'infrastructure de base de mon homelab avec Proxmox, l'étape suivante consiste à exposer les services de manière sécurisée et à automatiser leur déploiement. Pour cela, j'utilise **Nginx Proxy Manager** comme reverse proxy et **Ansible** pour l'automatisation. Cette configuration permet d'exposer facilement mes services en HTTPS tout en maintenant une gestion centralisée des certificats SSL.

## Architecture d'Exposition des Services

### Nginx Proxy Manager

Le reverse proxy est installé sur la VM `stargate` (192.168.1.134) qui sert de point d'entrée pour tous les services exposés. Cette configuration présente plusieurs avantages :

1. **Gestion centralisée des certificats SSL**
2. **Point d'entrée unique** pour tous les services
3. **Interface graphique intuitive** pour la configuration
4. **Renouvellement automatique** des certificats Let's Encrypt

La configuration est déployée via Ansible avec Docker Compose :

```yaml
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'   # HTTP
      - '443:443' # HTTPS
      - '81:81'   # Interface d'administration
    volumes:
      - /opt/nginx-proxy-manager/data:/data
      - /opt/nginx-proxy-manager/letsencrypt:/etc/letsencrypt
```

### Workflow d'Exposition d'un Service

Pour exposer un nouveau service, le processus est le suivant :

1. Le service est déployé sur une VM locale (par exemple, 192.168.1.105:8000)
2. Dans Nginx Proxy Manager, création d'un "Proxy Host" avec :
   - Domaine cible (ex: app.bookfarm.spacesheep.ovh)
   - Forward hostname/IP (ex: 192.168.1.105)
   - Forward port (ex: 8000)
   - Configuration SSL avec Let's Encrypt
3. Le service est alors accessible via HTTPS avec un certificat valide

## Automatisation avec Ansible

L'automatisation est cruciale pour maintenir un homelab efficace. J'utilise Ansible pour gérer les configurations et les déploiements sur l'ensemble des VMs.
```

### Inventaire des Hôtes

Le fichier `hosts.ini` définit toutes les VMs gérées par Ansible :

```ini
[vm_stargate]
192.168.1.134 ansible_user=ansible ansible_ssh_private_key_file=~/.ssh/ansible_key
...
```

### Playbook Docker

Un exemple concret d'automatisation est le playbook `docker.yml` qui installe Docker et Docker Compose sur toutes les VMs :

```yaml
- name: Install docker and docker compose on all machines
  hosts: vm_buckobserver:vm_shepherdess:vm_sheepyard:vm_rampasture:vm_nebulamb:vm_stargate
  become: true
  tasks:
    - name: Install Docker on Debian-based systems
      shell: |
        curl -fsSL https://get.docker.com | sh
      when: ansible_facts['os_family'] == 'Debian'

    - name: Install Docker and Docker Compose on Alpine-based systems
      apk:
        name:
          - docker
          - docker-compose
        state: present
      when: ansible_facts['os_family'] == 'Alpine'
...
```

Ce playbook utilise pas mal de mécanique de base de ansible. Par exemple, il :
- Détecte automatiquement le système d'exploitation
- Applique la méthode d'installation appropriée
- Vérifie les versions installées
- Configure le démarrage automatique du service

### Playbook Router

Le playbook `router.yml` configure automatiquement Nginx Proxy Manager sur la VM dédiée :

```yaml
- name: Setup router
  hosts: vm_stargate
  tasks:
    - name: Deploy Nginx Proxy Manager
      command: docker-compose up -d
      args:
        chdir: "{{ npm_path }}"
...
```

## Sécurité

La sécurité est assurée à plusieurs niveaux :

1. **HTTPS** systématique avec certificats Let's Encrypt
2. **Authentification HTTP** basique pour les services sensibles, géré par une *Access List* dans le panel admin du proxy.
4. **Accès SSH** uniquement par clé pour Ansible

Mon réseau local est accessible depuis l'extérieur grâce à Wireguard (inclus sur ma box internet Freebox Delta).

## Conclusion

Cette architecture d'exposition des services, combinée à l'automatisation Ansible, permet de :
- Déployer rapidement de nouveaux services
- Maintenir une sécurité élevée
- Réduire les tâches manuelles
- Assurer la reproductibilité des configurations

Les playbooks sont accessibles publiquement sur ce [dépot](https://github.com/nathanlq/ansible-task-manager) (à l'exception des fichiers exposant des infos sensibles).

Les prochains articles exploreront la mise en place du stockage centralisé et du monitoring, deux aspects essentiels pour compléter cette infrastructure.