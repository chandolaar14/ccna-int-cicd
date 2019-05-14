#!/bin/bash
set -ve
BUILDER_IMAGE=273850774494.dkr.ecr.us-east-1.amazonaws.com/df2-build:1.0.0

test -t 1 && USE_TTY="-t"

command="make $@"

docker run \
    -i \
    ${USE_TTY} \
    -v $(pwd):/working \
    -w /working \
    -e ENV=$ENV \
    ${BUILDER_IMAGE} \
    bash -c "$command"