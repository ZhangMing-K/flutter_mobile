#!/bin/sh

Cyan='\033[0;36m'     # Cyan

alias pod='arch -x86_64 pod'

# Update native dependencies 
echo -e "$Cyan \n Update native dependencies.. $Color_Off"
flutter clean 
flutter pub get
cd ios
pod repo update
pod install
cd .. 
flutter pub get