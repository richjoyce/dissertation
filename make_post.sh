#!/bin/bash

SHA=$1
TAG=$(git describe --tags ${SHA})
FILENAME=_posts/$(date +"%Y-%m-%d")-${SHA}.md
SHORT_MESSAGE=`git log -n 1 --pretty=format:%s ${SHA}`

mkdir -p _posts

echo "---" > $FILENAME
echo "layout: post" >> $FILENAME
echo "title: ${SHORT_MESSAGE}" >> $FILENAME
echo "date: `git show -s --format=%ci ${SHA}`" >> $FILENAME
echo "sha: ${SHA}" >> $FILENAME
if [ -z $TAG ]; then
    echo "categories: commit" >> $FILENAME
else
    echo "tag: $TAG" >> $FILENAME
    echo "categories: commit stable" >> $FILENAME
fi
echo "---" >> $FILENAME
git log -n 1 --pretty=format:%B $SHA >> $FILENAME
