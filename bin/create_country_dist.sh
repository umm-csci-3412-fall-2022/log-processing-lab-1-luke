#!/bin/bash

#Moves to given directory
cd "$1" || return

#Extract the ips from the failed login data
cat ./*/failed_login_data.txt | awk 'match($0, /[A-Za-z]+\s[0-9]+\s[0-9]+\s[A-Za-z_0-9.-]+\s([0-9.]+)/, groups) {print groups[1]}' | sort > ips.txt

#Creates a file with the country codes
join "$(pwd)"/ips.txt "$OLDPWD"/etc/country_IP_map.txt | awk '{print $2,$1}' | sort | awk '{print $1}' | uniq -c | awk 'match($0, /\s+([0-9]+)\s([A-Z]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, "groups[1]"]);"}' > codes.html

#Returns to orignal directory
cd "$OLDPWD" || return

#Wraps the country codes and the proper chart
./bin/wrap_contents.sh "$OLDPWD"/codes.html "$(pwd)"/html_components/country_dist "$OLDPWD"/country_dist.html

#Removes the leftover files
rm "$OLDPWD/ips.txt" "$OLDPWD/codes.html"
