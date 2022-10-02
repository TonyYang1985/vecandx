# vecandx

A new Flutter project.

## flutter submodule
> git submodule add https://github.com/flutter/flutter.git

## build  build.sh
```bash
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
```
## chmod  build.sh
> chmod u+x build.sh

## netlify  netlify.toml

```bash
[build]
  # Our Flutter Web build command
  command = "./build.sh"

  # The relative path to the directory to be published
  publish = "build/web"

```