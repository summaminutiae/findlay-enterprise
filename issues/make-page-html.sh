#!/bin/bash

# /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/images/01.jpg
# given the full filename of an image, create an html file for it

for img in $(gfind /Users/billw/git/findlay-enterprise/issues -path '*/images/[0-9][0-9].jpg' -type f | gsort); do
    fileName=$img                     # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/images/01.jpg
    fullBase="${fileName%.*}"         # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/images/01
    base="${fileName##*/}"            # 01.jpg
    page="${base%.*}"                 # 01
    dateDir="${fileName%/*/*}"        # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08
    date="${dateDir##*/}"             # 1986-08-08
    year="${date%%-*}"                # 1986

    echo "writing $fullBase.html"
    cat <<EOF > "$fullBase.html"
<!doctype html>
<html lang="en">
  <head>
    <title> Findlay Enterprise $date</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../../../../assets/thumbs.css">
  </head>
  <body>
    <a href="../../../../index.html">Year list</a> | <a href="../../weeks.html">Weeks list</a>
    <h1>The Findlay Enterprise</h1>
    <div class="newspaper">
      <figure>
        <figcaption>Page $page</figcaption>
        <img
          class="page"
          src="https://raw.githubusercontent.com/summaminutiae/findlay-enterprise/master/issues/$year/$date/images/$base"
          alt="Page$page.jpg">
      </figure>
    </div>
  </body>
</html>
EOF
done

# ${string#substring} deletes shortest match of $substring from front of $string
# ${string##substring} deletes longest match of $substring from front of $string

# ${string%substring} deletes shortest match of $substring from back of $string
# ${string%%substring} deletes longest match of $substring from back of $string

# for img in $(gfind /Users/billw/git/findlay-enterprise/issues -path '*/thumbs/[0-9][0-9].jpg' -type f | gsort); do
#     fullFile="$img"                   # /Users/billw/git/findlay-enterprise/issues/1986/1986-01-10/thumbs/01.jpg
#     fullBase="${fullFile%.*}"         # /Users/billw/git/findlay-enterprise/issues/1986/1986-01-10/thumbs/01
#     fullDir="${fullFile%/*}"          # /Users/billw/git/findlay-enterprise/issues/1986/1986-01-10/thumbs
#     filename="${fullFile##*/}"        # 01.jpg
#     page="${filename%.*}"             # 01
#     dateDir="${fullFile%/*/*}"        # /Users/billw/git/findlay-enterprise/issues/1986/1986-01-10
#     date="${dateDir##*/}"             # 1986-01-10
#     year="${date%%-*}"                # 1986
