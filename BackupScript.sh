#! /bin/bash

# Environment variables for borgbackup
export BORG_PASSPHRASE="borg"
REPOSITORY="borg@192.168.56.160:/var/backup/borg"

# Backup /etc
echo "Copy files to server"
borg create -v --stats $REPOSITORY::'Backup-{now:%Y-%m-%d@%H:%M}' /etc

# Deep 1 year, one copy in one month (without last three). The last three backups include everyday copies. 
echo "Clean old files" 
borg prune -v $REPOSITORY --prefix 'Backup-' --list --keep-daily=90 --keep-monthly=9 --keep-yearly 1

