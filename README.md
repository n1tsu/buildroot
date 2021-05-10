## Génerer les images des cameras

Pour les moments ces images sont en ARM pour QEMU

### Notes importantes

* Il faut lancer le `make -jX` en root pour le moment
* Il faut installer en local `gsoap`
* La premiere compilation va fail à la fin, il faudra modifier des fichiers:
  * `output/build/generic-onvif-server-{sha}/gsoap/stdsoap2.h`
  * `output/build/generic-onvif-server-{sha}/gsoap/stdsoap2.cpp`
  * `output/build/generic-onvif-server-{sha}/gsoap/dom.cpp`
* Pour chacun de ces fichiers, modifier le `#define GSOAP_VERSION 208111` par votre
  version gsoap (`soapcpp2 -V`)
  
C'est evidemment un vieux hotfix pour le moment, mais je pense que le fix
smoothly est un peu trop overkill.

### Commandes

``` sh
make sec_eole_defconfig # Importe la configuration
make -jX                # X etant le nombre de coeurs, spoiler: la compilation est longue
```

## Les fichiers intéressants

### configs/sec_eole_defconfig

La configuration qui est chargée, en cas de modification de configuration avec
l'interface (`make menuconfig`), il faut écraser cette config avec la commande
suivante:

``` sh
make savedefconfig BR2_DEFCONFIG=configs/sec_eole_defconfig
```

### board/advanced-epita-threats/sec-eole

Contient les autres ressources necessaire pour la generation des images.

#### cameras

Contient les configurations spécifiques de chaque caméras. Dans `frames` les
jpegs qui simuleront la vidéo, dans `images` l'emplacement dans lequel seront
géneré les images une fois la compilation fini, et dans `onvif.config` la
configuration pour le serveur onvif.

#### rootfs_overlay

Tout le contenu de ce dossier sera ajouté (en écrasant si besoin) au filesystem
de l'image géneré. Il contient notamment le fichier `S80onvif` responsable du
demarrage du serveur onvif en tant que daemon au boot de la machine.

#### post-script.sh

Script executé à la fin de la compilation pour copier l'image resultat en
plusieurs (pour chaque caméra) en ajoutant a chaque fois la configuration et
les fichiers spécifiques.
