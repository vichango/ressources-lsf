#!/bin/bash

# Run sign list regeneration.
docker run --rm \
    --volume="$(pwd)/scripts":"/home/lsf/scripts" \
    --volume="$(pwd)/list-signs":"/home/lsf/list-signs" \
    lsf-code:local "scripts/regenerate-sign-list.sh"
