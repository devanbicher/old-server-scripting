#!/bin/bash

#usually there are 3 content types that have this error. usually they have been deleted. 
#   image, blog, article
#BUT CHECK before doing this!! if the content type is still there it might cause problems

drush sqlq "delete from field_config_instance where bundle='blog';"
drush sqlq "delete from field_config_instance where bundle='article';"
drush sqlq "delete from field_config_instance where bundle='image';"