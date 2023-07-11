#!/bin/bash

# ${string#substring} deletes shortest match of $substring from front of $string
# ${string##substring} deletes longest match of $substring from front of $string

# ${string%substring} deletes shortest match of $substring from back of $string
# ${string%%substring} deletes longest match of $substring from back of $string

# Use the ? wildcard for file globbing

# - create each of /Users/billw/git/findlay-enterprise/issues/1986/index.html
# - this index.html should point to specific issues: e.g.,
#   http://members.wolfram.com/billw/findlay-enterprise/issues/1985/1985-02-15/

for dir in $(gfind /Users/billw/git/findlay-enterprise/issues -path '*/[0-9][0-9][0-9][0-9]' -type d | gsort); do
    # dir is /Users/billw/git/findlay-enterprise/issues/1984
    year="${dir##*/}" # 1984

    echo "writing $dir/index.html"
    cat <<EOF > "$dir/index.html"
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../../assets/styles.css">
    <title> Findlay Enterprise $year</title>
  </head>
  <body>
    <a href="../index.html">Year list</a>
    <h1>The Findlay Enterprise</h1>
    <h3>Dates published this year</h3>
    <div class="newspaper">
EOF

    for d in $(gfind $dir -path '*/????/????-??-??' -type d | gsort); do
        # d is /Users/billw/git/findlay-enterprise/issues/1984/1984-03-02
        date="${d##*/}"

        cat <<EOF >> "$dir/index.html"
      <p><a href=$date>$date</a></p>
EOF
    done


cat <<EOF >> "$dir/index.html"
    </div>
  </body>
</html>
EOF
done
