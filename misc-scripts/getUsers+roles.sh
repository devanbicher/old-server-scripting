#!/bin/bash

set -e

##this script gets a list of all users, their uid's, and their roles, from all of the current sites
##  NOTE: THIS DOES NOT RETURN USERS WITH NO ROLES. 
####  for that simply use the query:  "select uid, name from users"

echo -e "PLEASE NOTE:  THIS DOES NOT RETURN USERS WITH NO ASSIGNED ROLES\n\n"

sitelist='users+roles-site-listing.txt'

#first get the list of the sites:
find /etc/drupal7/ -mindepth 1 -maxdepth 1 ! -type l -type d | grep .cas2.lehigh.edu | cut -d '/' -f 4 | sort > $sitelist

while read -r sitedir
do

    cd /etc/drupal7/$sitedir
    echo "$sitedir :"

#this is the drush command to use:
    drush sqlq "select users.uid, users.name, users_roles.rid, role.name from ((users inner join users_roles on users.uid=users_roles.uid) inner join role on role.rid=users_roles.rid) order by users.uid, role.name;" | column -c 4 -ts $'\t'

    echo -e "\n"

done < $sitelist