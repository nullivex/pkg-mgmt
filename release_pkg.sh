#!/bin/bash

cd $1

echo "Grabbing updates and merging"
git checkout master
git pull
git checkout 0.0.x-dev
changes=$(git rev-list --left-right --count master...HEAD | awk '{print $1'})
if [ $changes -eq 0 ]; then
        echo "No changes to release"
        exit
fi
git merge master
version="0.0.$(expr $(git tag | grep -oP "\d+$" | sort -n | tail -1) + 1)"
echo "New Version $version"
git tag $version
git checkout master
git push && git push --tags
echo "Done"
