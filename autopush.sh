#!/bin/bash

push() {
        for line in $1; do
                echo "Pushing $line"
                cd $line;
                git push && git push --tags
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

echo "Packages to be pushed:"
to_release=$(cat to_release | grep -oP "[0-9a-z\-]+$")
echo -e "$to_release"

read -r -p "Are you sure? [Y/n] " response
case $response in
        [yY][eE][sS]|[yY])
                push "$to_release"
                exit
                ;;
        *)
                echo "Will not release"
                exit
                ;;
esac