#!/bin/sh

set -e

BUILD_DIR=./build
if [ -d "$BUILD_DIR" ]; then
	rm -rf $BUILD_DIR
fi
mkdir $BUILD_DIR
cd $BUILD_DIR

hugo new site . --force
git clone https://github.com/hugo-sid/hugo-blog-awesome.git themes/hugo-blog-awesome
sed -i 's/\$narrow-size: 720px;/\$narrow-size: 900px;/' themes/hugo-blog-awesome/assets/sass/main.scss

rm hugo.toml && ln -s "../hugo.toml" "./hugo.toml"
rm -rf content && ln -s "../geekembly" "./content"
rm -rf assets && ln -s "../assets" "./assets"
rm -rf layouts && ln -s "../layouts" "./layouts"

if [ "$1" = "build" ]; then
	HUGO_ENV=production hugo --minify
else
	hugo server --minify --bind 0.0.0.0
fi
