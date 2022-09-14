#!/bin/bash

#Moves to given directory
cd "$1" || return

#Combines the three created html files to generate the report
cat country_dist.html hours_dist.html username_dist.html > report.html

#Returns to the original directory
cd "$OLDPWD" || return

#Wraps the report with the relevant header and footer
./bin/wrap_contents.sh "$OLDPWD"/report.html html_components/summary_plots "$OLDPWD"/failed_login_summary.html

#Removes temporary files
rm "$OLDPWD/report.html"
