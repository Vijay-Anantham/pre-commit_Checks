#!/usr/bin/env python

import os
import re
import sys

def check_file_names():
    # Get a list of all files that have been added or modified
    files = os.popen('git diff --cached --name-only --diff-filter=AM').read().split('\n')

    # Define the pattern that the filenames should follow
    pattern = r'^[\w-]+\.[\w]+$'  # e.g., word characters, hyphen, period, word characters

    # Check each file
    for filename in files:
        # Ignore deleted files
        if not os.path.exists(filename):
            continue

        # Check for spaces in filename
        if ' ' in filename:
            print(f'Error: The file "{filename}" contains spaces.')
            return 1

        # Check if filename follows the correct format
        if not re.match(pattern, filename):
            print(f'Error: The file "{filename}" does not follow the correct naming format.')
            return 1

    return 0

if __name__ == "__main__":
    sys.exit(check_file_names())