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

#creating release Branch($releaseBranch)

git checkout $releaseBranch

#creating feature branch($featureBranch) from develop branch($devBranch)

git checkout -b $featureBranch $devBranch
git push --all origin

fileName="testfile.txt"
sed -i.backup -E "s/\= v[0-9.]+/\= $versionLabel/" $versionFile $versionFile


# remove backup file created by sed command
rm $versionFile.backup
 
# commit version number increment
git commit -am "Incrementing version number to $versionLabel"
 
# merge feature branch into release branch 
git checkout $featureBranch
git merge --no-ff $releaseBranch

