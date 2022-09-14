#!/bin/bash

#Moves to given directory
cd "$1" || return

#Generates temporary username distribution file for given directory
cat ./*/failed_login_data.txt | awk 'match($0, /[A-Za-z]+\s[0-9]+\s[0-9]+\s([A-Za-z_0-9\.\-]+)/, groups) {print groups[1]}' | sort | uniq -c | awk 'match($0, /\s+([0-9]+)\s([A-Za-z_0-9\.\-]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, "groups[1]"]);"}' > names.html

#Moves to original directory
cd "$OLDPWD" || return

#Properly wraps the contents of the username distribution
./bin/wrap_contents.sh "$OLDPWD"/names.html "$(pwd)"/html_components/username_dist "$OLDPWD"/username_dist.html

#Removes temporary file from directory
rm "$OLDPWD/names.html"
