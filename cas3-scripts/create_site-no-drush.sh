#!/bin/bash
#
# Usage --> sh create_site-no-drush.sh <sitename> 
#
# This script is just like the normal site creation script, but does not execute the drush commands, so that a different database can be used 
#####  At least, that is its primary intended purpose.

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

####  THIS commented-out section below is for copying the old theme, there is another script for this:
########   create_site-both-themes.sh
# Copy the adaptive Shell theme to the new themes folder, replace generic name with site name
#echo "copying the shell theme for posterity. This can be deleted if desired."
#path=$1/themes/$1'_adaptive_2017';
#cp -r all/themes/Adaptive_Shell_Theme/ $path;
#mv $path/adaptive_shell.info $path/$1'_adaptive_2017'.info;
#sed -i "s/Adaptive Shell Theme/$1 Adaptive Theme 2017/" $path/$1'_adaptive_2017'.info;


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

####  This script does not do the drush commands
#cd $1;
#echo "setting file_public_path to \"files/'$1'\"." 
#drush vset file_public_path "files/$1";
#drush en "$1_2018";
#drush vset theme_default "$1_2018";
#drush cc all;

# Notify the user to update the sites.php file and create the database
#echo "If you recieved errors on the drush commands it is because you forgot to create the database first."
echo "REMEMBER:  the public file path and theme related stuff still needs to be set."
echo "Add the following line to the sites.php file" 
echo "'$1.cas3.lehigh.edu' => '$1',";
echo " "
echo "DO NOT FORGET TO RESET THE PASSWORD FOR USER-1: castopadmin"

echo "$1.cas3.lehigh.edu   has been created on cas-drupal-dev.dept.lehigh.edu. Using the create_site-no-drush.sh script
     Add the following line to the sites.php file:
              '$1.cas3.lehigh.edu' => '$1',

      Login at $1.cas3.lehigh.edu/user  
      Then go to  $1.cas3.lehigh.edu/admin/appearance to enable and set default your new theme, then save the settings for the theme." | mail -s "$1.cas3.lehigh.edu created" dlb213@lehigh.edu
