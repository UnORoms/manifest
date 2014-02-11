#!/bin/bash

echo ".....-----===== UnORoms Project =====-----......"
echo "Initializing Devices branch : $1"

if [ ! $1 ]
then
   echo "Devices branch cannot be empty"
   exit 1
fi

if [ ! -d .repo/local_manifests ]
then
   mkdir -p .repo/local_manifests
fi

repo forall -p -c `"git reset --hard && git clean -f -d"`

if [ "$(ls -A .repo/local_manifests )" ]
then
	rm -f .repo/local_manifests/*
fi

wget https://raw.github.com/UnORoms/manifest/master/unoroms.xml
script="s/%deviceBranch%/$1/g"
sed $script unoroms.xml > .repo/local_manifests/unoroms.xml
repo sync -j8 -f vendor/unoroms/scripts
repo sync -j8 -f vendor/unoroms/devices
rm -f unoroms.xml
rm -f init.sh

