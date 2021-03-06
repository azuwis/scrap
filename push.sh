#!/bin/bash
cd `dirname $0`
echo "AUTO COMMIT" > .git/AUTO_COMMIT_MSG
echo >> .git/AUTO_COMMIT_MSG
git status --porcelain | awk '/^\?\? data/ {print $2}' | while read d
do
	if [ -e $d/index.dat ]; then
		title=`grep ^title $d/index.dat | cut -f 2-`
		echo "add page: $title" >> .git/AUTO_COMMIT_MSG
	fi
done

git add .
git commit --all --file .git/AUTO_COMMIT_MSG && git push git@github.com:azuwis/scrap.git gh-pages
