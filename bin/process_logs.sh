#!/bin/bash

temp="$(mktemp -d)"
#Extract all of the given tar files into the scratch directory
#Run procces_client_logs on each of the files moved into the scratch directory
for tar in "$@"; do
		logDir="$temp"/"$(basename "$tar" .tgz)"
			mkdir "$logDir"
				tar -xzf "$tar" -C "$logDir"
					./bin/process_client_logs.sh "$logDir"
				done

				#Create files containing all of the specified distributions
				./bin/create_hours_dist.sh "$temp"
				./bin/create_username_dist.sh "$temp"
				./bin/create_country_dist.sh "$temp"

				#Assemble the report of all the distributions created after the helper scripts run
				./bin/assemble_report.sh "$temp"

				#Move the generated report into the current directory
				mv "$temp"/failed_login_summary.html "$(pwd)"

				#Remove the scratch directory
				rm -r "$temp"
