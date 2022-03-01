#!/bin/bash

cd /etc/drupal7/bicherdevantestsite.cas2.lehigh.edu/

drush pm-list --type=module | sed -e 's/  \+/,/g' | sed 's/,$//g' | grep -v "Package,Name,Status,Version" | cut -d, -f2- > ~/cas2modules-$(date +'%m%d%y-%H%M').csv