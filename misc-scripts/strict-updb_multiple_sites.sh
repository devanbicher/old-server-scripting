#!/bin/bash
set -u
set -e

sitelist="$1"

while read -r sitename
do
    cd "/etc/drupal7/$sitename"
    echo -e "\nNOW updating in ..."
    pwd
    
    drush cc all
    drush --yes updb
    drush cc all

done < "$sitelist"