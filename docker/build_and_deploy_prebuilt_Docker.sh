#!/bin/bash

# This is to prepare the pre-built Docker image
    # that will be used as base image of ModelArray + ConFixel's Docker image
# More professional way: set this into a CircleCI of `ModelArray_tests``

# ++++++++++++++++++++++++++++++++++++++++++++++++++++
docker_tag="0.0.1"

filename_dockerfile="Dockerfile_build"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++

## Build:
# !! command below must be run in folder `ModelArray_tests/docker`
docker build -t pennlinc/modelarray_build:${docker_tag} \
    -f ${filename_dockerfile} .
    # ^^ this will take 30-40min
# TODO: next time: try out `cache-from` and `--rm=false` - see ModelArray repo's circle ci
    # might save time?

## Test:
# mrconvert

# R:
    # > library(devtools)


## Push
# we need to use multi-architecture,
# so that docker image built on Mac M1 can be run on other architectures e.g., cubic with amd64
# ref: https://docs.docker.com/desktop/multi-arch/
# from Mac M1 system:
docker buildx use mybuilder   # use the builder which gives access to the new multi-architecture features. | created by: $ docker buildx create --name mybuilder
docker buildx build --platform linux/amd64,linux/arm64 \
    --push -t pennlinc/modelarray_build:${docker_tag} \
    -f ${filename_dockerfile} .

    # this will take 1h+ on a Mac M1 laptop (~double time of only `docker build` one architecture)
    # see above some tryouts to save time?