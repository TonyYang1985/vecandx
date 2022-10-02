#!/bin/bash

# Get flutter
# git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter

# Configure flutter
# $FLUTTER channel stable

FLUTTER_CHANNEL=stable
FLUTTER_VERSION=v3.3.3
$FLUTTER channel $FLUTTER_CHANNEL
$FLUTTER version $FLUTTER_VERSION

# $FLUTTER upgrade
$FLUTTER config --enable-web
# build web
$FLUTTER build web --release

echo "Build Web Application Success!!!"