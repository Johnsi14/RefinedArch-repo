#!/bin/bash
#
# RefinedArch
# https://github.com/Johnsi14/RefinedArch
# Script for Pushing all files to the Github


set -euo pipefail

if (( "$#" == 1 )) 
then
    if [ "$1" = "-r" ] 
    then
    ./update_db.sh "-r"
    fi
else 
./update_db.sh
fi


git pull

git add .

echo "##########################################"
echo "Enter your Commit Message"
echo "##########################################"

read -r input


git commit -m "Manual Push: $input"



git push -u origin 



echo "##########################################"
echo "Commit and Push Completed"
echo "##########################################"