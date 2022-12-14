#!/bin/bash

#Moves to specified directory
cd "$1" || return

#Filters log files for failed login attempts
cat var/log/secure* | awk 'match($0, /([a-zA-Z]+)\s+([0-9]+\s[0-9]+).*(Failed\spassword\sfor\sinvalid\suser|Failed\spassword\sfor) ([a-zA-Z0-9_\-\.]+)\sfrom\s([0-9\.]+)/, groups) {print groups[1] " " groups[2] " " groups[4] " " groups[5]}' > failed_login_data.txt

