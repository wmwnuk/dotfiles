#!/bin/sh

THEME_FILES=${THEME_FILES:=~/Projects/dotfiles/theme-files}

cp -r $THEME_FILES/.local ~
cp -r $THEME_FILES/.themes ~
cp -r $THEME_FILES/.icons ~
