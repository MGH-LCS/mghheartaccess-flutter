#!/bin/bash
flutter clean
flutter pub get
cd ios
rm -fr .symlinks
rm -fr pods
rm -f podfile.lock
pod install
cd ..
