#!/bin/bash

drush sqlq 'select nid from node order by nid;' > /home/dlb213/lists-users+sites+files/node-lists/$( pwd | rev | cut -d '/' -f 1 | rev)-NODES.txt