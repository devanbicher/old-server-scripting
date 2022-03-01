#!/bin/bash
#
# Usage --> sh create_site.sh <sitename> 
#
#  This Script is just like the normal site creation script except that it also copies the old, beige theme as well.

# $1 is the name of the first parameter passed to any script, here it is the same as sitename
echo "Making theme for $1";

# Set a variable to the drupal sites folder 
DR=/var/www/html/drupal/sites
cd $DR

# Create the site directory
mkdir $1;

# If you want to auto create the files folder, uncomment this line
mkdir ../files/$1
chgrp casadmin ../files/$1

# Create drupal folders inside the sites folder
mkdir $1/themes;
mkdir $1/modules;

# Copy in the settings.php folder, set the database name
cp settings.php.main $1/settings.php;
sed -i "s/DATABASE_NAME/$1/" $1/settings.php;

#####  Updating the sites.json file below stopped working, I believe due to a permission thing.  Plus it's not quite useful anymore
# Update the sites.json file in the default folder, used the default page
# This step is for updating the list of files that is used in the "Ooops!, ...wrong place..." javascript thing
#sed -i "s/\]/, \"$1\"]/" ../files/default/sites.json

# Copy the adaptive Shell theme to the new themes folder, replace generic name with site name
echo "copying the shell theme for posterity. This can be deleted if desired."
path=$1/themes/$1'_adaptive_2019';
cp -r all/themes/Adaptive_Shell_Theme/ $path;
mv $path/adaptive_shell.info $path/$1'_adaptive_2019'.info;
sed -i "s/Adaptive Shell Theme/$1 Adaptive Theme 2019/" $path/$1'_adaptive_2019'.info;
#Not going to change the title in the header, not add the add css since this theme is really only being copied in for testing and for posterity

# Copy the NEW clean theme to the new themes folder, replace generic name with site name
path=$1/themes/$1'_2019';
cp -r all/themes/clean_template_theme2018/ $path;
mv $path/clean_template_theme2018.info $path/$1'_2019'.info;
mv $path/css/REPLACE.ME.css $path/css/$1.css;

#REPLACE_THEME_NAME-2018
sed -i "s/REPLACE_THEME_NAME-2018/$1 Theme 2019/" $path/$1'_2019'.info;
#update the css file in the info file
sed -i "s/REPLACE.ME.css/$1.css/" $path/$1'_2019'.info;
#update the site name in the header of the page.tpl.php
sed -i "s/REPLACE-THE-SITE-TITLE/$1/" $path/page.tpl.php

cd $1;
echo "setting file_public_path to \"files/'$1'\"." 
drush vset file_public_path "files/$1";
drush en "$1_2019";
drush vset theme_default "$1_2019";
#Get uli link to send in email to make loggin in easier
ulipath=$(drush uli dlb213 | cut -d'/' -f4-)
ulilink="https://$1.cas3.lehigh.edu/$ulipath"

#udpate the admin password
echo "updating the user-1 password";
pass=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n1);
#echo $pass;
drush user-password --password="$pass" castopadmin;

drush cc all;

# Notify the user to update the sites.php file and create the database
echo "If you recieved errors on the drush commands it is because you forgot to create the database first."
echo "If there were errors in the drush commands then DO NOT FORGET TO RESET THE PASSWORD FOR USER-1: castopadmin"
echo "Add the following line to the sites.php file" 
echo "'$1.cas3.lehigh.edu' => '$1',";

echo "$1.cas3.lehigh.edu   has been created on cas-drupal-dev.dept.lehigh.edu. Using the create_site-both-themes.sh script

      Add the following line to the sites.php file:
              '$1.cas3.lehigh.edu' => '$1',

      Use the following link to login: $ulilink

      Go to  https://$1.cas3.lehigh.edu/admin/appearance/settings/$1_2019 to save the settings for the theme.

      Login regularly at https://$1.cas3.lehigh.edu/user " | mail -s "$1.cas3.lehigh.edu created" dlb213@lehigh.edu
