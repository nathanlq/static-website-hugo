---
title: "Homelab : Bios, proxmox et ip locales"
date: 2024-12-29
draft: false
tags: ["proxmox", "homelab", "virtualisation", "hyperviseur"]
---

Dans le cadre de mon projet homelab, qui vise à créer un environnement informatique personnel pour héberger divers services et expérimenter avec différentes technologies, la première étape consistait à installer et configurer Proxmox VE comme hyperviseur sur mes deux serveurs. Ce choix s'inscrit dans une architecture plus large comprenant un routeur, deux serveurs de virtualisation et un NAS Synology, permettant de centraliser et d'automatiser la gestion de mes services personnels.

## Pourquoi Proxmox ?

Proxmox VE (Virtual Environment) est un hyperviseur de type 1, aussi appelé "bare metal", ce qui signifie qu'il s'exécute directement sur le matériel, contrairement aux hyperviseurs de type 2 (comme VirtualBox ou VMware Workstation) qui nécessitent un système d'exploitation hôte. Cette architecture offre plusieurs avantages cruciaux pour un homelab :

- Performance optimale avec un accès direct aux ressources matérielles
- Meilleure isolation des machines virtuelles
- Gestion efficace des ressources système
- Interface web intuitive pour la gestion des VMs et conteneurs
- Fonctionnalités entreprise (haute disponibilité, migration à chaud) gratuites
- Large communauté open source active

## Architecture Globale

Mon installation repose sur deux serveurs distincts :
- **Spacesheep** (sans GPU) : Dédié aux services légers et à l'automatisation
- **Lambdah** (avec GPU) : Optimisé pour les workloads nécessitant de la puissance de calcul graphique

Ces serveurs sont complémentés par :
- Un NAS Synology pour le stockage centralisé
- Un routeur pour la gestion réseau et la sécurité qui peut héberger des vm (en l'occurence la Freebox Delta)

## Prérequis Matériels

### Configuration du BIOS
Pour assurer une virtualisation performante, plusieurs paramètres BIOS sont essentiels :
- Activation de SVM pour les processeurs AMD (cette technologie permet la virtualisation matérielle, similaire à VT-x sur Intel)
- Activation de l'IOMMU pour la virtualisation du GPU (permet le passage direct des périphériques PCI aux VMs)
  - Vérification possible via la commande : `dmesg | grep -e DMAR -e IOMMU`

### Protection Électrique
La stabilité d'un homelab repose beaucoup sur la qualité de son alimentation électrique. Pour protéger l'infrastructure :
- Installation d'un [parafoudre](https://www.amazon.fr/gp/product/B07X2T4DSS/ref=ox_sc_act_title_3) pour sécuriser l'alimentation
- Mise en place d'un système de [mesure de consommation](https://www.amazon.fr/gp/product/B0BTJ1DTBX/ref=ox_sc_act_title_2) pour le monitoring
- Configuration du BIOS pour le redémarrage automatique après une coupure de courant (crucial pour maintenir les services disponibles)

## Installation de Proxmox

### Préparation
1. Téléchargement de l'ISO Proxmox VE depuis le [site officiel](https://www.proxmox.com/en/)
2. Création d'une clé USB bootable
3. Configuration du boot sur USB dans le BIOS

### Configuration Réseau
La configuration réseau est une étape à noter pour assurer la communication entre les différents composants :

Configuration IP statique pour chaque serveur :
- Serveur sans GPU (spacesheep)
- Serveur avec GPU (lambdah)
- Interface web accessible sur le port 8006 (https://IP:8006)

Ces IPs sont réservées dans la configuration DHCP du routeur pour garantir leur stabilité. A noter que l'ip publique de mon routeur est fixe (chose que permet la freebox delta)

## Configuration du Cluster

La mise en place d'un cluster Proxmox est essentielle pour une gestion centralisée. Elle permet :
- La migration de VMs entre les nœuds
- La réplication des configurations
- Une interface d'administration unique
- Une meilleure résilience en cas de panne

Configuration du cluster :

```bash
# Sur le nœud maître
pvecm create nom_du_cluster

# Sur les nœuds secondaires
pvecm add ip_master

# Vérification du statut
pvecm status
```

## Intégration du NAS Synology

### Configuration du Stockage NFS
Le NAS Synology joue un rôle central dans l'architecture :

1. [Configuration du partage NFS sur le NAS Synology](https://kb.synology.com/fr-fr/DSM/tutorial/how_to_set_up_Synology_NFS_share_as_Proxmox_storage)
2. Montage du partage `/volume1/Proxmox` sur les serveurs Proxmox
3. Utilisation comme stockage centralisé pour :
   - Images ISO des systèmes d'exploitation
   - Sauvegardes des VMs et conteneurs
   - Templates et snippets Proxmox
   - Autres artefacts de configuration

Le NAS synology est également accessible à distance via QuickConnect à l'adresse https://nathanleclercq.fr2.quickconnect.to/

## Les VMs

Histoire d'être en adéquation avec la ligne éditoriale, toutes les objets, machines etc. seront tant que cela est possible nommés sur le thème des ovidés spatiaux, je me retrouve donc avec cette liste :
- **Stargate** : La seule vm qui sera à terme sur le routeur, là où tourne tout ce qui concerne le réseau et ce qui ne dois absolument pas être couper.
- **Sheepyard** : Une vm qui tourne sur mon serveur sans gpu ou je mettrai toute ma flotte de conteneur qui n'ont besoin ni de gpu ni de stockage, juste de RAM et de CPU.
- **Rampasture** : Sur le serveur sans GPU, avec un stockage sur le NAS, c'est là où je mettrai tout ce qui a besoin d'espace mais pas trop de puissance.
- **Buckobserver** : La vm de monitoring, sur le serveur sans GPU.
- **Nebulamb** : La plus puissante de toute, unique vm sur le serveur GPU, avec un PCI-Passthrough de la carte graphique. Si ça peut utiliser CUDA, je le met dessus.

### GPU PCI-Passthrough

Pour dédié une carte graphique entièrement à une vm sur proxmox, il faut tout d'abord activer IOMMU dans le BIOS de sa machine. Ensuite, il faut éditer la configuration de la machine où tourne proxmox :

```bash
$ nano /etc/default/grub
...
GRUB_CMDLINE_LINUX_DEFAULT="quiet amd_iommu=on=on iommu=pt" # où intel, ça dépend de votre machine
...
$ update-grub
$ reboot
```

Ensuite, il faut regarder dans quel groupe se trouve la carte graphique :

```bash
for d in /sys/kernel/iommu_groups/*/devices/*; do
    echo "IOMMU Group $(basename $(dirname $d)):"; lspci -nns $(basename $d); echo;
done
```

Après cela, normalement IOMMU est activé et disponible, vous pouvez vérifier cela avec :

```bash
dmesg | grep -e DMAR -e IOMMU
```

Vous devriez trouver des lignes avec votre carte dedans, pour moi il y en avait une pour l'audio et une pour le VGA controller. Si tout est dans le même groupe comme pour moi, tout va bien et vous pouvez continuer, sinon il faut demander à Google comment les mettre dans le même groupe. Ensuite, il ne reste plus qu'à éditer un fichier de configuration pour pouvoir accéder à ce matériel depuis l'interface proxmox :

```bash
$ lspci -nns | grep -i vga
... # vous devriez voir les PCI IDs de votre carte
$ nano /etc/modprobe.d/vfio.conf
...
options vfio-pci ids=10de:1b06,10de:10ef # mettez les bons IDs
...
$ update-initramfs -u
$ reboot
```

Après ça, vous pouvez juste assigner le gpu dans la configuration de la vm. N'oubliez pas de désactiver celui par défaut. De mon coté, j'ai d'abord dû installer le systême de ma vm avec un GPU simulé, installer les drivers NVIDIA puis la redémarrer pour obtenir un joli print de ce type à l'intérieur :

```bash
nathan@nebulamb:~$ nvidia-smi    
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 550.120                Driver Version: 550.120        CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 4060 Ti     Off |   00000000:01:00.0 Off |                  N/A |
|  0%   36C    P8              8W /  165W |       2MiB /  16380MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|  No running processes found                                                             |
+-----------------------------------------------------------------------------------------+
```

Et voilà, votre VM devrait savoir utiliser le GPU. Cela ne veut pas dire que vos conteneurs le peuvent, pour cela il faut ajouter le paquet approprié, pour moi c'était celui [là](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html). Vous pouvez ensuite tester cela avec cet [exemple](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/sample-workload.html).

## Conclusion

Voilà ce que j'ai après tout ça :

![images](/proxmox.png)

L'installation de Proxmox sur les deux serveurs du homelab fournit une base solide pour la virtualisation et la conteneurisation. La configuration en cluster offre une flexibilité accrue et une meilleure résilience, tandis que l'intégration avec le NAS Synology assure un stockage centralisé et fiable.

Cette infrastructure servira de fondation pour héberger divers services comme :
- Environnements de développement
- Services de monitoring
- Solutions d'automatisation
- Bases de données
- Services web personnels

Les prochaines étapes consisteront à déployer ces services virtualisés et à mettre en place un système de monitoring complet pour surveiller la santé et les performances de l'infrastructure.

Pour en savoir plus sur les services que j'héberge sur cette infrastructure, vous pouvez consulter mon article sur l'architecture globale de mon homelab.