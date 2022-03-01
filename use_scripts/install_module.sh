#!/bin/bash

# This smmal script installs a module in the current directory giving a url for the zip file
# example usage:
# sh install_module.sh https://ftp.drupal.org/files/projects/og-7.x-2.9.zip

# add the functionality to install multiple modules at a time 

# get the name of the zip file for extraction
url=$1
zipfile=$(echo $url | rev | cut -f1 -d'/' | rev)


echo "this is the zip file"
echo $zipfile

#download the file
wget $url

#at some point in the future put in a simple if statement to test if it's a zip file or a tar.gz file so it can extract either

#extract the contents
unzip $zipfile

#remove the zip file
rm $zipfile

ls -la
