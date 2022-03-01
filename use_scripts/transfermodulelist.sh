#!/bin/bash

time=$(date +%m%d%y%H%M)

modulelist="/home/dlb213/modulelists/$1"'-modules-'"$time.txt"
modulecsv="/home/dlb213/modulelists/$1"'-modules-'"$time.csv"

drush pm-list --type=module --status=enabled,disabled > "$modulelist"

sed 's/  \+/,/g' "$modulelist" | sed 's/,$//g' | grep -v "Package,Name,Status,Version" | cut -d, -f2- > "$modulecsv"

scp "$modulecsv" dlb213@cas4.cc.lehigh.edu:~/cas2modulelists/