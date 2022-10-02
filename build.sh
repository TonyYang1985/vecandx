#!/bin/bash

# Get flutter
# git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter

# Configure flutter
$FLUTTER channel beta
$FLUTTER upgrade
$FLUTTER config --enable-web
# build web
$FLUTTER build web --release

echo "Build Web Application Success!!!"