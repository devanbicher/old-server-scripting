#!/bin/bash

types=$(drush sqlq "select type from node_type;")

for bundle in $types
do
    echo "$bundle counts:"
    drush sqlq "select count(*) from node where type='$bundle';" | grep -v 'count'
done

#drush sqlq "select count(*) from node where type='page';"