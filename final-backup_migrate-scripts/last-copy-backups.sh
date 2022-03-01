#!/bin/bash

for fol in */; do

if [ -d "$fol" ]; then

    echo "$fol"
    
    ls -l "$fol"/files/private/backup_migrate/*/

    mkdir /home/dlb213/FINAL-backup_migrate/FINAL-backup_migrations/"$fol"

    cp -r "$fol"/files/private/backup_migrate/* /home/dlb213/FINAL-backup_migrate/FINAL-backup_migrations/"$fol"

fi

done
