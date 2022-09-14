#!/bin/bash

#Moves to given directory
originaldir=$(pwd)
cd "$1" || return
newdir=$(pwd)

#Generates temporary username distribution file for given directory
cat ./*/failed_login_data.txt | awk 'match($0, /[A-Za-z]+\s[0-9]+\s[0-9]+\s([A-Za-z_0-9.-]+)/, groups) {print groups[1]}' | sort| uniq -c | awk 'match($0, /\s+([0-9]+)\s([A-Za-z_0-9.-]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, "groups[1]"]);"}' > names.html

#Moves to original directory
cd "$originaldir" || return

#Properly wraps the contents of the username distribution
./bin/wrap_contents.sh "$newdir"/names.html "$originaldir"/html_components/username_dist "$newdir"/username_dist.html

#Removes temporary file from directory
rm "$newdir/names.html"
