#!/bin/sh

set -e

WORK_DIR=$(pwd)

if [ ! -d "/hugo" ]; then
  echo "creating hugo project"
  mkdir /hugo && cd /hugo
  hugo new site docs --format yaml
  cd docs
	hugo mod init geekembly
	cp -r $WORK_DIR/hugo.yaml /hugo/docs
	hugo mod get -u
fi

# cd $WORK_DIR && (reflex -r '\.md$' -s -- sh -c './fix_files.sh') &
# sleep 2
cp -r $WORK_DIR/docs/* /hugo/docs/content/
cd /hugo/docs && hugo server -D --bind 0.0.0.0
