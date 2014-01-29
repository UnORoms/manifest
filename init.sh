#!/bin/bash

echo ".....-----===== UnORoms Project =====-----......"
echo "Initializing Devices branch : $1"

if [ ! $1 ]
then
   echo "Devices branch cannot be empty"
   exit 1
fi


wget https://raw.github.com/UnORoms/manifest/master/unoroms.xml
sed 's/%deviceBranch%/$1/g' unoroms.xml > .repo/local_manifests/unoroms.xml
repo sync -j8 -f vendor/unoroms/scripts
repo sync -j8 -f vendor/unoroms/devices
rm -f unoroms.xml
rm -f init.sh

