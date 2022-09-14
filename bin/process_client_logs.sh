#!/bin/bash

#Moves to specified directory
cd "$1" || return

#Filters log files for failed login attempts
cat var/log/secure* | awk 'match($0, /([a-zA-Z]+)\s+([0-9]+\s[0-9]+).*(invalid\suser|Failed\spassword\sfor)\s([a-zA-Z0-9]+)\sfrom\s([0-9\.]+)/, groups) {print groups[1] " " groups[2] " " groups[4] " " groups[5]}' > failed_login_data.txt
