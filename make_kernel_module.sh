#!/bin/bash
set -e

# Build the kernel module
make

# Check the exit code of make
if [ $? -ne 0 ]; then
    echo "Error: make failed. Exiting."
    exit 1
fi

