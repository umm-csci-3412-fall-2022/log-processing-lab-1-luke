#!/bin/bash

#Moves to specified directory
#cd "$1"/var/log

#Extracts
cat *.txt > allfiles.txt
awk 'match($0, /([a-zA-Z]+\s[0-9]+\s[0-9]+).*(invalid\suser|Failed\spassword\sfor)\s([a-zA-Z]+)\sfrom ([0-9.]+)/, groups) {print groups[1] " " groups[3] " " groups[4]}' < allfiles.txt >> failed_login_data.txt
