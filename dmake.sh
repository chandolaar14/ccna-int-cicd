#!/bin/bash
set -ve
BUILDER_IMAGE=362550720160.dkr.ecr.us-west-2.amazonaws.com/int-build:1.0.13

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