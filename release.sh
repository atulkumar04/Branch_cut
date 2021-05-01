#!/bin/bash





#current git branch

branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo "Current brach is $branch"
echo ""

#setting up the version labels
version=$1
versionLabel=v$version

if [ -z "$version" ]; then 
 echo "Please specify a versionLable to continue"
 exit
fi

devBranch=develop
featureBranch="feature/$versionLabel"
releaseBranch="release/$versionLabel"

echo "Feature Branch is $featurebranch"
echo "Release Branch is $releaseBranch"

#creating feature branch($featureBranch) from develop branch($devBranch)

git checkout -b $featureBranch $devBranch
git push --all origin
