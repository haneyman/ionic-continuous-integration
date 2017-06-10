#!/usr/bin/env bash
sudo cordova plugin rm cordova-plugin-console
sudo cordova plugin add cordova-plugin-console

sudo cordova plugin rm cordova-plugin-device
sudo cordova plugin add cordova-plugin-device

sudo cordova plugin rm cordova-plugin-keyboard
sudo cordova plugin add cordova-plugin-keyboard

sudo cordova plugin rm cordova-plugin-splashscreen
sudo cordova plugin add cordova-plugin-splashscreen

sudo cordova plugin rm cordova-plugin-statusbar
sudo cordova plugin add cordova-plugin-statusbar
#sudo cordova plugin rm cordova-plugin-whitelist
#sudo cordova plugin add cordova-plugin-whitelist

sudo cordova plugin rm cordova-plugin-inappbrowser
sudo cordova plugin add cordova-plugin-inappbrowser

sudo cordova plugin rm cordova-plugin-camera
sudo cordova plugin add cordova-plugin-camera

sudo ionic plugin rm cordova-plugin-x-socialsharing
sudo ionic plugin add cordova-plugin-x-socialsharing
sudo npm install --save @ionic-native/social-sharing

sudo ionic plugin rm cordova-plugin-native-keyboard
sudo ionic plugin add cordova-plugin-native-keyboard
sudo npm install --save @ionic-native/native-keyboard
