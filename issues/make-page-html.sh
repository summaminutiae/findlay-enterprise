#!/bin/bash

# create an html file for each page image such that
# http://members.wolfram.com/billw/findlay-enterprise/issues/1986/1986-04-18/images/01.html
# displays page 1 of the April 18, 1986 issue

for img in $(gfind /Users/billw/git/findlay-enterprise/issues -path '*/images/[0-9][0-9].jpg' -type f | gsort); do
    fileName=$img              # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/images/01.jpg
    fullBase="${fileName%.*}"  # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/images/01
    base="${fileName##*/}"     # 01.jpg
    page="${base%.*}"          # 01
    dateDir="${fileName%/*/*}" # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08
    date="${dateDir##*/}"      # 1986-08-08
    year="${date%%-*}"         # 1986

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
    <a href="../../../../index.html">Year list</a> | <a href="../../index.html">Weeks list</a>
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
