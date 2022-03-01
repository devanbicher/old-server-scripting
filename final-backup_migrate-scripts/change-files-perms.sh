#!/bin/bash

for fol in */; do

if [ -d "$fol" ]; then

    echo "$fol"
    
    ls -l "$fol"/files/private/backup_migrate/*/
    
    sudo mkdir -p "$fol"/files/private/backup_migrate/manual/
    
    sudo chmod -R 777 "$fol"/files/private/

    #mkdir /home/dlb213/FINAL-backup_migrate/all-backup_migratesB4finalbb/"$fol"

    #cp -r "$fol"/files/private/backup_migrate/* /home/dlb213/FINAL-backup_migrate/all-backup_migratesB4finalbb/"$fol"

fi

done
