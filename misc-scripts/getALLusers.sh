#!/bin/bash

set -e

## since my other script only gets users with roles, this gets all users even ones with no roles, but obviously not their roles


sitelist='ALLusers-site-listing.txt'

#first get the list of the sites:
find /etc/drupal7/ -mindepth 1 -maxdepth 1 ! -type l -type d | grep .cas2.lehigh.edu | cut -d '/' -f 4 | sort > $sitelist

while read -r sitedir
do

    cd /etc/drupal7/$sitedir
    echo "$sitedir :"

#this is the drush command to use:
    drush sqlq "select uid, name from users order by uid;" | column -c 4 -ts $'\t'

    echo -e "\n"

done < $sitelist