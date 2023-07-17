#!/bin/bash

year=1975

echo "bringing files from $year into the repo..."
rsync -a /Users/billw/Dropbox/projects/Findlay-Enterprise/enterprise/$year/ /Users/billw/git/findlay-enterprise/issues/$year

echo "deleting all weeks.html and thumbs.html..."
gfind /Users/billw/git/findlay-enterprise/issues/$year -type f -name 'weeks.html' -delete
gfind /Users/billw/git/findlay-enterprise/issues/$year -type f -name 'thumbs.html' -delete

echo "creating an html file for each page..."
/Users/billw/git/findlay-enterprise/issues/make-page-html.sh
echo "creating an index file for each issue..."
/Users/billw/git/findlay-enterprise/issues/make-week-index.sh
echo "creating an index file for each year"
/Users/billw/git/findlay-enterprise/issues/make-year-index.sh

echo "done.";