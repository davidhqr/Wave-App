# Wave Flutter (Android & iOS) App

[![Contact](https://img.shields.io/badge/contact-%40davidhqr-blue)](https://github.com/davidhqr)
[![GitHub license](https://img.shields.io/github/license/davidhqr/Wave-App)](https://github.com/davidhqr/Wave-App)
[![GitHub issues](https://img.shields.io/github/issues/davidhqr/Wave-App)](https://github.com/davidhqr/Wave-App/issues)
[![GitHub stars](https://img.shields.io/github/stars/davidhqr/Wave-App)](https://github.com/davidhqr/Wave-App/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/davidhqr/Wave-App)](https://github.com/davidhqr/Wave-App/network)

## Overview

This is the Wave Flutter App. It allows for the transfer of images and text over sound.

Wave Backend API: https://github.com/davidhqr/Wave-API \
Wave React Web App: https://github.com/lindaayangg/Wave-Web

## Structure

[Home Page](Home.md)  
[Send Text Page](SendText.md)  
[Send Image Page](SendImage.md)


## Setup
1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Install Android Studio and its Flutter Plugin: https://flutter.dev/docs/get-started/editor
3. Accept the Android SDK license: `~/Library/Android/sdk/tools/bin/sdkmanager --licenses`

## Building
1. Execute `flutter build apk` to build the Android APK
2. Execute `flutter build ios` to build the iOS app

## Running
1. Connect device or open iOS/Android simulator
2. Execute `flutter run`

## Deploying to Google Play
1. Reference: https://flutter.dev/docs/deployment/android
2. Generate `key.jks` and add your `key.properties`
3. Execute `flutter build appbundle`
4. Upload the app bundle to Google Play Console
5. Follow instructions in Google Play Console

## Deploying to the App Store
1. Reference: https://flutter.dev/docs/deployment/ios
2. Create an archive in Xcode
3. Upload the archive to App Store Connect
4. Follow instructions in App Store Connect

## Troubleshooting

### The sandbox is not in sync with the Podfile.lock
1. Execute `flutter clean`
2. Delete `Podfile.lock` and the `Pods` folder from `/ios`
3. Execute `pod install --repo-update`
