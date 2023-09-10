#!/bin/bash

# * usage

read -r -d '' usage <<'EOF'
main.sh: call other page-creation scripts

Usage:
------

main.sh [-y year]
  -y: [year number]
  -h: help
EOF


# * process arguments

while getopts 'y:' flag
do
    case "${flag}" in
        y) export yearArg=${OPTARG};;
        h) echo "$usage" >&2
           exit 1 ;;
        *) echo "$usage" >&2
           exit 1 ;;
    esac
done

echo "bringing files from $yearArg into the repo..."
rsync -a /Users/billw/Dropbox/projects/Findlay-Enterprise/enterprise/$yearArg/ /Users/billw/git/findlay-enterprise/issues/$yearArg

echo "deleting all weeks.html and thumbs.html..."
gfind /Users/billw/git/findlay-enterprise/issues/$yearArg -type f -name 'weeks.html' -delete
gfind /Users/billw/git/findlay-enterprise/issues/$yearArg -type f -name 'thumbs.html' -delete

echo "creating an html file for each page..."
/Users/billw/git/findlay-enterprise/issues/make-page-html.sh -y $yearArg
echo "creating an index file for each issue..."
/Users/billw/git/findlay-enterprise/issues/make-week-index.sh -y $yearArg
echo "creating an index file for each year"
/Users/billw/git/findlay-enterprise/issues/make-year-index.sh -y $yearArg

echo "done.";