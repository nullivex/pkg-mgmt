#!/bin/bash

edit() {
	for line in $1; do
		echo "Editing $line"
		cd $line;
		git checkout master
		sed -i "s/~0.0.1/dev-master/g" composer.json
		git commit -a -m "fixed versioning for dev"
		git checkout 0.0.x-dev
		git merge master
		sed -i "s/dev-master/~0.0.1/g" composer.json
		git commit -a -m "changed version world for branch"
		cd ..
	done
}

if [ -z to_release ]; then
	echo "Release file ./to_release doesnt exist; create it; one package per line"
	exit
fi

if [ $(cat to_release | wc -l) -eq 0 ]; then
	echo "No packages to push"
	exit
fi

echo "Packages to be edited:"
to_release=$(cat to_release | grep -oP "[0-9a-z\-]+$")
echo -e "$to_release"

read -r -p "Are you sure? [Y/n] " response
case $response in
	[yY][eE][sS]|[yY])
		edit "$to_release"
		exit
		;;
	*)
		echo "Will not edit"
		exit
		;;
esac

