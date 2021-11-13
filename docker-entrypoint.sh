#!/bin/bash

# Make scripts executable.
chmod u+x /home/lsf/scripts/*.sh

# Call CMD.
source "$@"
