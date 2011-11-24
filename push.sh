#!/bin/bash
echo > .git/AUTO_COMMIT_MSG
git status --porcelain | awk '/^\?\? data/ {print $2}' | while read d
do
	if [ -e $d/index.dat ]; then
		title=`grep ^title $d/index.dat | cut -f 2-`
		echo "add page: $title" >> .git/AUTO_COMMIT_MSG
	fi
done

git add .
git commit --file .git/AUTO_COMMIT_MSG
#git push
