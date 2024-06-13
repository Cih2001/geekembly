#!/bin/sh

set -e

WORK_DIR=$(pwd)
BUILD_DIR=$WORK_DIR/build

if [ ! -d "$BUILD_DIR" ]; then
  echo "creating hugo project"
  mkdir $BUILD_DIR && cd $BUILD_DIR
  hugo new site geekembly --format yaml
  cd geekembly
	hugo mod init geekembly
	cp -r $WORK_DIR/hugo.yaml $BUILD_DIR/geekembly
	hugo mod get -u
fi

cp -r $WORK_DIR/geekembly/* $BUILD_DIR/geekembly/content/
cd $BUILD_DIR/geekembly && hugo
