#!/bin/bash

cd $1

dev_branch="0.0.x-dev"

echo "Grabbing updates and merging"

# jump to master just to be sane
git checkout master

# pull down any updates
git pull
if [ $(git branch | grep $dev_branch | wc -l) -eq 0 ]; then
	echo "$dev_branch devel branch doesnt exist, cant release"
	exit
fi

# move to dev branch and pull then merge in master
git checkout $dev_branch
git pull origin $dev_branch

# check for changes from master
changes=$(git rev-list --left-right --count master...HEAD | awk '{print $1'}) 
if [ $changes -eq 0 ]; then
	echo "No changes to release"
	exit
fi

# merge master changes in
git merge master

# figure new version
version="0.0.$(expr $(git tag | grep -oP "\d+$" | sort -n | tail -1) + 1)"
echo "New Version $version"
git tag $version

# switch back to master
git checkout master

# check for changes in master and push if we have them
master_changes=$(git rev-list --left-right origin/master...HEAD --count | awk '{print $2}')
dev_changes=$(git rev-list --left-right origin/$dev_branch...HEAD --count | awk '{print $2}')
if [ $master_changes -gt 1 ] || [ $dev_changes -gt 1 ]; then
	git push
fi

# check for changes in master and push if we have them
changes=$(git rev-list --left-right origin/master...HEAD --count | awk '{print $2}')
if [ $changes -gt 1 ]; then
	git push
fi


# check new tags that need to be pushed
if [ $(git ls-remote --tags origin | wc -l) -lt $(git tag | wc -l) ]; then
	git push --tags
fi

echo "Done"

