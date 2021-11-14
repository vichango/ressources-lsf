#!/bin/bash

# Run sign list regeneration.
docker run --rm \
    --volume="$(pwd)/scripts:/home/lsf/scripts" \
    --volume="$(pwd)/videos:/home/lsf/videos" \
    lsf-code:local "scripts/resize-encode.sh"
