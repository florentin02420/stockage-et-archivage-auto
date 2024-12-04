#!/bin/bash

# Installer l'outil FTP si nécessaire
apt install -y ftp

# Chemins et configurations
SOURCE_DIR="/var/lib/docker/volumes/ed33ff8a80e8e8648103c2cd1b8acdb9edf349d50ca866126db50733a39a4ec8/_data/data/admin/files/toip"
BACKUP_DIR="/backup_owncloud"
DATE=$(date +"%d-%m-%Y_%H:%M:%S")
DESTINATION="$BACKUP_DIR/sio2-$DATE"

# Informations FTP
FTP_SERVER="ftp.votre-serveur.com"   # Remplacez par l'adresse de votre serveur FTP
FTP_USER="votre_utilisateur_ftp"    # Remplacez par votre nom d'utilisateur FTP
FTP_PASS="votre_mot_de_passe_ftp"   # Remplacez par votre mot de passe FTP
FTP_REMOTE_DIR="/sauvegardes/toip"  # Répertoire distant où les fichiers seront stockés

# Vérifier que le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur : le répertoire source $SOURCE_DIR n'existe pas."
    exit 1
fi

# Créer le répertoire de destination local s'il n'existe pas
mkdir -p "$DESTINATION"

# Copier les fichiers localement avec rsync
rsync -a --progress "$SOURCE_DIR/" "$DESTINATION/"

# Vérifier si la copie locale a réussi
if [ $? -ne 0 ]; then
    echo "Erreur lors de la copie locale."
    exit 1
fi

echo "Sauvegarde locale réussie : $DESTINATION"

# Transfert FTP
echo "Démarrage du transfert FTP..."

ftp -inv $FTP_SERVER <<EOF
user $FTP_USER $FTP_PASS
cd $FTP_REMOTE_DIR
mput $DESTINATION/*
bye
EOF

# Vérifier le statut du transfert
if [ $? -eq 0 ]; then
    echo "Transfert FTP réussi vers $FTP_REMOTE_DIR"
else
    echo "Erreur lors du transfert FTP."
    exit 1
fi
