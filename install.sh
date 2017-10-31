#!/bin/bash
QT_BASE_DIR=$HOME/.config/QtProject
QTCREATOR_INSTALL_DIR=$QT_BASE_DIR/qtcreator
QBS_INSTALL_DIR=$QT_BASE_DIR/qbs
SYNTAXDIR=$QTCREATOR_INSTALL_DIR/generic-highlighter/
WIZARDDIR=$QTCREATOR_INSTALL_DIR/templates/wizards/

cd qbs

MODULEDIR=$QBS_INSTALL_DIR/modules/hal/
mkdir -p $MODULEDIR
cp -v ./modules/hal/*.qbs $MODULEDIR

IMPORTDIR=$QBS_INSTALL_DIR/imports/qbs/base/
mkdir -p $IMPORTDIR
cp -v ./imports/*.qbs $IMPORTDIR
cd ..

cd qtcreator

cd syntax
mkdir -p $SYNTAXDIR
cp -v *.* $SYNTAXDIR
cd ..

cd wizards
mkdir -p $WIZARDDIR
cp -v -r * $WIZARDDIR
cd ..
