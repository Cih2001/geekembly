#!/bin/sh

set -e

WORK_DIR=$(pwd)
BUILD_DIR=$WORK_DIR/build

if [ -d "$BUILD_DIR" ]; then
	rm -rf $BUILD_DIR
fi 

echo "creating hugo project"
mkdir $BUILD_DIR && cd $BUILD_DIR
hugo new site geekembly
cd geekembly
git clone https://github.com/hugo-sid/hugo-blog-awesome.git themes/hugo-blog-awesome
sed -i 's/\$narrow-size: 720px;/\$narrow-size: 900px;/' themes/hugo-blog-awesome/assets/sass/main.scss
cp -r $WORK_DIR/hugo.toml $BUILD_DIR/geekembly
cp -r $WORK_DIR/geekembly/* $BUILD_DIR/geekembly/content/
cp -r $WORK_DIR/assets/* $BUILD_DIR/geekembly/assets/
cp -r $WORK_DIR/layouts/* $BUILD_DIR/geekembly/layouts/

if [ "$1" = "build" ]; then
	HUGO_ENV=production hugo --minify
elif [ "$1" = "run" ]; then
	hugo server --liveReload --bind 0.0.0.0 
else
	echo "invalid argument: $1"
	exit 1
fi

exit 0
