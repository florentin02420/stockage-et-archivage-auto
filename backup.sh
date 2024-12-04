#!/bin/bash

# Installer rsync si nécessaire
apt install -y rsync

# Chemins et configurations
SOURCE_DIR="/var/lib/docker/volumes/ed33ff8a80e8e8648103c2cd1b8acdb9edf349d50ca866126db50733a39a4ec8/_data/data/admin/files/toip"
BACKUP_DIR="/backup_owncloud"
DATE=$(date +"%d-%m-%Y_%H:%M:%S")
DESTINATION="$BACKUP_DIR/sio2-$DATE"

# Vérifier que le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur : le répertoire source $SOURCE_DIR n'existe pas."
    exit 1
fi

# Créer le répertoire de destination s'il n'existe pas
mkdir -p "$DESTINATION"

# Copier les fichiers avec rsync
rsync -a --progress "$SOURCE_DIR/" "$DESTINATION/"

# Vérifier si la copie a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : $DESTINATION"
else
    echo "Erreur lors de la sauvegarde."
    exit 1
fi
