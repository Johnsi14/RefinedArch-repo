#!/usr/bin/env bash
#
# RefinedArch
# https://github.com/Johnsi14/RefinedArch
# Script for building the Database of the RefinedArch repository
# Heavyly inspired from the dtos Distrubution/Repository   https://www.gitlab.com/dwt1/refined-repo
# Thanks to Derek Taylor / Distrotube for creating the original version of the Script

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

#Uncomment this line if it is on Gitlab to not have to enter it every time
#set -- "-r"

echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64
cd x86_64
rm -f refined-repo*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in the database
## -R: remove old package files when updating their entry
repo-add -s -n -R refined-repo.db.tar.gz */*.pkg.tar.zst


#Check if the symlinks should be removed because the repository may be on GitLab
if (( "$#" == 1 )) 
then
   if [ "$1" = "-r" ] 
    then
    echo "something"
    fi 
exit 1
fi


echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"

removing_symlinks() {
# Removing the symlinks because GitLab can't handle them.
rm refined-repo.db
rm refined-repo.db.sig
rm refined-repo.files
rm refined-repo.files.sig

# Renaming the tar.gz files without the extension.
mv refined-repo.db.tar.gz refined-repo.db
mv refined-repo.db.tar.gz.sig refined-repo-db.sig
mv refined-repo.files.tar.gz refined-repo.files
mv refined-repo.files.tar.gz.sig refined-repo.files.sig

echo "#######################################"
echo "Symlinks have been removed"
echo "#######################################"
}
