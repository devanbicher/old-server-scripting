#!/bin/bash

for fol in */; do

if [ -d "$fol" ]; then

    echo "$fol"
    
    ls -l "$fol"/files/private/backup_migrate/*/
    
    mkdir -p "$fol"/files/private/backup_migrate/manual/
    
    chmod -R 777 "$fol"/files/private/

    cd $fol

    drush vget file_public_path 

    drush vset file_public_path "sites/$fol/files"
    
    drush vget file_private_path 
    
    drush vset file_private_path "sites/$fol/files/private"
    
    cd /etc/drupal7

    #mkdir /home/dlb213/FINAL-backup_migrate/all-backup_migratesB4finalbb/"$fol"

    #cp -r "$fol"/files/private/backup_migrate/* /home/dlb213/FINAL-backup_migrate/all-backup_migratesB4finalbb/"$fol"

fi

done
