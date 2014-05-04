#!/bin/bash
QTCREATORDIR=$1/Tools/QtCreator
TARGETDIR=$QTCREATORDIR/share/qtcreator/qbs
SYNTAXDIR=~/.config/QtProject/qtcreator/generic-highlighter/

cd qbs

MODULEDIR=$TARGETDIR/share/qbs/modules/hal/
mkdir -p $MODULEDIR
cp -v ./modules/hal/*.qbs $MODULEDIR

IMPORTDIR=$TARGETDIR/share/qbs/imports/qbs/base/
mkdir -p $IMPORTDIR
cp -v ./imports/*.qbs $IMPORTDIR
cd ..

cd qtcreator

cd syntax
mkdir -p $SYNTAXDIR
cp -v *.* $SYNTAXDIR
cd ..