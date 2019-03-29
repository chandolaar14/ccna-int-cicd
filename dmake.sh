#!/bin/bash
set -ve

test -t 1 && USE_TTY="-t"

command="make $@"

docker run \
    -i \
    ${USE_TTY} \
    -v $(pwd):/working \
    -w /working \
    -e ENV=$ENV \
    beauknowssoftware/builder:1.0.2 \
    bash -c "$command"