#!/bin/bash

cd qbs
TARGETDIR=$1/share/qtcreator/qbs
mkdir -p $TARGETDIR/modules/hal
cp ./modules/hal/*.qbs $TARGETDIR/modules/hal/

mkdir -p $TARGETDIR/imports
cp ./imports/*.qbs $TARGETDIR/imports/
cd ..

cd qtcreator

cd syntax
cp *.* ~/.config/QtProject/qtcreator/generic-highlighter/
cd ..