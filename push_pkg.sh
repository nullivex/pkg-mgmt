#!/bin/bash
 
pkg="$1"
 
cd $1
 
#check for untracted files
if [ $(git status | grep -i "Untracked files" | wc -l) -gt 0 ]; then
        echo "Untracked files cant push"
        exit
fi
 
git commit -a -m "$2"
commit=$(git log | head -1 | awk '{print $2}')
git checkout master
git merge $commit
git push
