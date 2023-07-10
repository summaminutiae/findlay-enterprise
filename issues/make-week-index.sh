#!/bin/bash

# ${string#substring} deletes shortest match of $substring from front of $string
# ${string##substring} deletes longest match of $substring from front of $string

# ${string%substring} deletes shortest match of $substring from back of $string
# ${string%%substring} deletes longest match of $substring from back of $string

# Use the ? wildcard for file globbing

 # - create each of /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/index.html
 # - this index.html should point to https://raw.githubusercontent.com/summaminutiae/findlay-enterprise/master/issues/$year/$date/thumbs/$base

for dir in $(gfind /Users/billw/git/findlay-enterprise/issues -path '*/????/????-??-??' -type d | gsort); do
    # dir is /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08
    date="${dir##*/}"  # 1986-08-08
    year="${date%%-*}" # 1986

    echo "writing $dir/index.html"
    cat <<EOF > "$dir/index.html"
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../../../assets/weeks.css">
    <title> Findlay Enterprise $date</title>
  </head>
  <body>
    <a href="../../index.html">Year list</a> | <a href="../index.html">Weeks list</a>
    <h1>The Findlay Enterprise</h1>
    <h3>Pages published this week</h3>
    <div class="newspaper">
EOF

    for f in $(gfind $dir -type f -path '*/thumbs/*.jpg' -print | gsort); do
        fileName=$f                # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/thumbs/01.jpg
        fullBase="${fileName%.*}"  # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08/thumbs/01
        base="${fileName##*/}"     # 01.jpg
        page="${base%.*}"          # 01
        dateDir="${fileName%/*/*}" # /Users/billw/git/findlay-enterprise/issues/1986/1986-08-08
        date="${dateDir##*/}"      # 1986-08-08
        year="${date%%-*}"         # 1986

        echo "        <figure>
          <a href='images/$page.html'>
             <img class='thumb' alt='Page$page' src='https://raw.githubusercontent.com/summaminutiae/findlay-enterprise/master/issues/$year/$date/thumbs/$base'>
          </a>
          <figcaption>Page $page.jpg</figcaption>
        </figure>" >> $dir/index.html
    done

    cat <<EOF >> "$dir/index.html"
    </div>
  </body>
</html>
EOF
done