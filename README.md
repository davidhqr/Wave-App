# Wave Flutter App

## Overview

This is the Wave Flutter App. It allows for the transfer of images and text over sound.

Wave Backend API: https://github.com/davidhqr/Wave-API

## Structure

### Home Page
- Button to toggle listening for Waves
- History widget which contains previously received Waves
- Popup when a Wave is received

### Screenshots:
Home:

<img src="https://github.com/davidhqr/Wave-App/blob/master/screenshots/wave_home.jpg" width="200">

Home Listening:

<img src="https://github.com/davidhqr/Wave-App/blob/master/screenshots/wave_home_listen.jpg" width="200">

Home Receiving:

<img src="https://github.com/davidhqr/Wave-App/blob/master/screenshots/wave_home_receive.jpg" width="200">

### Send Text Page
- Toggle button to toggle between online and offline mode

### Screenshots:
Send Text Online:

<img src="https://github.com/davidhqr/Wave-App/blob/master/screenshots/wave_send_text_online.jpg" width="200">

Send Text Offline:

<img src="https://github.com/davidhqr/Wave-App/blob/master/screenshots/wave_send_text_offline.jpg" width="200">

### Send Image Page
- Image selector to choose the image to send

### Screenshots:
Send Image:

<img src="https://github.com/davidhqr/Wave-App/blob/master/screenshots/wave_send_image.jpg" width="200">

## Setup
1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Install Android Studio and its Flutter Plugin: https://flutter.dev/docs/get-started/editor
3. Accept the Android SDK license: `~/Library/Android/sdk/tools/bin/sdkmanager --licenses`

## Building
1. Execute `flutter build apk` to build the Android APK
2. Execute `flutter build ios` to build the iOS app

## Running
1. Connect device
2. Execute `flutter run`

## Deploying to Google Play
Soon

## Deploying to the App Store
Soon
