#!/bin/bash

# Specify the pattern that filenames should match.
# This pattern checks for files that start with "file" and end with ".txt"
pattern="^devx.*\.py$"

# Get a list of all files that have been added or modified.
files=$(git diff --cached --name-only --diff-filter=AM)

# Check each file.
for file in $files
do
    # Get the base name of the file (the part of the name after the last '/').
    base=$(basename "$file")

    # If the base name of the file does not match the pattern
    if [[ ! $base =~ $pattern ]]
    then
        echo "Error: File '$file' does not follow the naming convention."
        exit 1
    fi
done

# If all files match the pattern, exit with success status.
exit 0