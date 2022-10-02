#!/bin/bash

# Get flutter
git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter

# Configure flutter
# $FLUTTER_BIN channel beta
# $FLUTTER_BIN upgrade
$FLUTTER config --enable-web
$FLUTTER_BIN build web --release

echo "Build Web Application Success!!!"