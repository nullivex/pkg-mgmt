#!/bin/bash

release(){
	for line in $1; do
		echo
		echo "Releasing $line"
		./release_pkg.sh $line
		echo
	done
}

if [ -z to_release ]; then
	echo "Release file ./to_release doesnt exist; create it; one package per line"
	exit
fi

if [ $(cat to_release | wc -l) -eq 0 ]; then
	echo "No packages to release"
	exit
fi

echo "Packages to be released:"
to_release=$(cat to_release | grep -oP "[0-9a-z\-]+$")
echo -e "$to_release"

read -r -p "Are you sure? [Y/n] " response
case $response in
	[yY][eE][sS]|[yY])
		release "$to_release"
		exit
		;;
	*)
		echo "Will not release"
		exit
		;;
esac
