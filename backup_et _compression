#!/bin/bash
apt install zip
# Chemins et configurations
SOURCE_DIR="/var/lib/docker/volumes/ed33ff8a80e8e8648103c2cd1b8acdb9edf349d50ca866126db50733a39a4ec8/_data/data/admin/files/toip"
BACKUP_DIR="/backup_owncloud"
DATE=$(date +"%d-%m-%Y_%H:%M:%S")
BACKUP_FILE="$BACKUP_DIR/sio2-$DATE.zip"

# Vérifier que le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur : le répertoire source $SOURCE_DIR n'existe pas."
    exit 1
fi


# Compresser le contenu du répertoire source dans un fichier ZIP
zip -r "$BACKUP_FILE" "$SOURCE_DIR" > /dev/null 2>&1

# Vérifier si la compression a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : $BACKUP_FILE"
else
    echo "Erreur lors de la création de la sauvegarde."
    exit 1
fi
