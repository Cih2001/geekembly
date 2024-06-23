#!/bin/sh

set -e

WORK_DIR=$(pwd)
BUILD_DIR=$WORK_DIR/build

echo "creating hugo project"
cd $BUILD_DIR/geekembly

if [ ! -e "hugo.toml"]; then
	hugo new site .
	git clone https://github.com/hugo-sid/hugo-blog-awesome.git themes/hugo-blog-awesome
	sed -i 's/\$narrow-size: 720px;/\$narrow-size: 900px;/' themes/hugo-blog-awesome/assets/sass/main.scss
	cp -r $WORK_DIR/hugo.toml $BUILD_DIR/geekembly
fi;

hugo server --minify --bind 0.0.0.0
