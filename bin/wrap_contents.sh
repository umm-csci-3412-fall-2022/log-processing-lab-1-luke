#!/bin/bash

header="$2"_header.html
footer="$2"_footer.html

cat "$header" "$1" "$footer" > "$3"
