#!/bin/bash


read -n 1 -p "Set private file path to " setpath

echo ""
echo ""

if [ $setpath == "y" ];then
    echo "okay we will set the path"
fi