#!/bin/bash

# Run sign list regeneration.
docker run --rm \
    --volume="$(pwd)/scripts":"/home/lsf/scripts" \
    --volume="$(pwd)/list-phrases":"/home/lsf/list-phrases" \
    lsf-code:local "scripts/regenerate-phrase-list.sh"
