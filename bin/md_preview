#!/bin/zsh

# Updated: 2022-12-21
# Takes a markdown file path in the clipboard and tries to convert
# the file to html. Then, open the file. Useful for previewing docs
# generated in Obsidian.

# relative_path=`pbpaste`
# full_path="/Users/philipcatterall/notes/$1/$relative_path"

full_path="`pbpaste`"

if [ $# -ne 2 ]; then
  echo "Error: incorrect number of arguments"
  exit 1
fi

# if the argument is valid
if [[ "$2" == "gh" ]]; then
	css="github.css"
elif [[ "$2" == "gd" ]]; then
	css="gdocs.css"
else
	echo "Error: argument must be gh (github) or gd (google docs)." >&2
	exit 1
fi

# if the filepath in the clipboard is valid, run pandoc and open the html output
if [[ -f "$full_path" ]]; then
	pandoc -c ~/notes/.support/css/$css -f gfm -s "$full_path" -o ~/notes/.support/out.html --quiet
	open ~/notes/.support/out.html
else
  # If it doesn't, print an error message
  echo "Error: $full_path does not exist." >&2
fi

