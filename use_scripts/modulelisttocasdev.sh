#!/bin/bash

read -n 1 -p "Did you backup the module list on cas3?  ONLY KEEP GOING FULL SCREEN!!" keepgoing

echo ""
echo ""

if [ $keepgoing == "y" ];then
    cd /etc/drupal7/bicherdevantestsite.cas2.lehigh.edu/
    
    drush pm-list --type=module > cas2_modules.txt
    
    scp cas2_modules.txt dlb213@cas-drupal-dev.dept.lehigh.edu:~/use_scripts/cas2modulecheck/

    rm cas2_modules.txt

fi



