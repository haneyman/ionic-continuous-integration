#!/bin/sh

# fail on first failed command
set -e

# $GREENHOUSE_BUILD_DIR points to the cloned repository root

# suppose you have PHP code in repo_root/php and there is also composer.json
# then you can install dependencies with composer like
#cd $GREENHOUSE_BUILD_DIR/php
npm install
mkdir www
