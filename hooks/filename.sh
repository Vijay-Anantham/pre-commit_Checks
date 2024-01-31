#!/bin/bash

# Specify the pattern that filenames should match.
# This pattern checks for files that start with "devx" and end with ".py"
pattern="^devx.*\.py$"

# Specify the file to exclude
exclude=".pre-commit-config.yaml"

# Get a list of all files that have been added or modified.
files=$(git diff --cached --name-only --diff-filter=AM)

# Check each file.
for file in $files
do
    # Get the base name of the file (the part of the name after the last '/').
    base=$(basename "$file")

    # If the base name of the file is the excluded file, skip this iteration
    if [[ $base == $exclude ]]
    then
        continue
    fi

    # If the base name of the file does not match the pattern
    if [[ $file == *"-"* ]]; 
    then
        echo "Error: File $file has malformed name formatting. convention do not support '-' in names"
        exit 1
    fi
done

# If all files match the pattern, exit with success status.
exit 0