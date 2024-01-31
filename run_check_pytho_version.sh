#!/bin/bash

# The required Python version.
required_python_version=$1

# Check if the required version is provided
if [ -z "$required_python_version" ]
then
      echo "No Python version provided. Please provide a Python version as an argument."
      exit 1
fi

# Get the current Python version.
current_python_version=$(python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')

# Compare the current and required Python versions.
if [ "$(printf '%s\n' "$required_python_version" "$current_python_version" | sort -V | head -n1)" != "$required_python_version" ]; then 
    echo "Your Python version is not compatible. Please use Python $required_python_version or higher."
    exit 1
fi

# No issues, exit with success status
exit 0