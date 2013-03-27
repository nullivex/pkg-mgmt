#!/bin/bash

cd $1

echo "Grabbing updates and merging"
git pull
git checkout 0.0.x-dev
git merge master
git checkout master
version=0.0.$(expr $(git tag | tail -1 | grep -oP "(\d+)$") + 1)
echo "New Version $version"
git tag $version
git push && git push --tags
echo "Done"
