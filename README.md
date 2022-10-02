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


> dart migrate

> dart pub outdated --mode=null-safety


Update dependencies
Before migrating your package’s code, update its dependencies to null-safe versions:

> Run dart pub upgrade --null-safety 
to upgrade to the latest versions supporting null safety. Note: This command changes your pubspec.yaml file.

Run dart pub get.
> dart pub get

We recommend fixing the analysis issues before running `dart migrate`.
Alternatively, you can run `dart migrate --ignore-errors`, but you might
get erroneous migration suggestions.


>dart migrate   
>dart pub outdated --mode=null-safety