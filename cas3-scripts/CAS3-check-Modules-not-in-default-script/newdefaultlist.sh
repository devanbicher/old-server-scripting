#!/bin/bash

#go to the directory for the default dp
cd /var/www/html/drupal/sites/devandefaultdb

#copy the dbnew settings file to settings.php
cp settings-dbnew.php.bu settings.php

drush cc all

time=$(date +%m%d%y%H%M)

mv ~/use_scripts/check-modules/default-modules.csv ~/use_scripts/check-modules/backup-default-lists/default-modules-$time.csv

drush pm-list --type=module --fields=name,version,status --format=csv | grep -i enabled > ~/use_scripts/check-modules/default-modules.csv

#copy back the regular db file

cp settings-devandefaultdb.php.bu settings.php

drush cc all
