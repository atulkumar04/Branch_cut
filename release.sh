#!/bin/bash





#current git branch

branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo "Current brach is $branch"
echo ""

#setting up the version labels
version=$1
versionLabel=$version

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

echo "Creating release Branch $releaseBranch"
echo ""
git checkout -b $releaseBranch >/dev/null

#creating feature branch($featureBranch) from develop branch($devBranch)

echo "creating feature branch from develop branch"
echo ""
git checkout -b $featureBranch $devBranch >/dev/null

echo "Incrementing files version"

fileName="testfile.txt"
sed -i.backup -E "s/\= [0-9][0-9][0-9][0-9].[0-9]*.[0-9]*-SNAPSHOT+/\= $versionLabel-SNAPSHOT/" $fileName $fileName


# remove backup file created by sed command
rm $fileName.backup
 
# commit version number increment
echo "Commit changes to feature branch"

git commit -am "Incrementing version number to $versionLabel" >/dev/null
 
# merge feature branch into release branch 
echo "Merging  feature branch into release branch"

git checkout $releaseBranch >/dev/null
git merge --no-ff $featureBranch >/dev/null

git push --all origin >/dev/null
