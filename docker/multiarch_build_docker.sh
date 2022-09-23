#!/bin/bash

# This is to try out multi-arch building,
    # so that the docker image can also be run on Mac M1 computer
# THIS IS STILL UNDER TESTING.....

# Multi-arch build & push
# we need to use multi-architecture,
# so that docker image built on Mac M1 can be run on other architectures e.g., cubic with amd64
# ref: https://docs.docker.com/desktop/multi-arch/
# from Mac M1 system:
docker buildx use mybuilder   # use the builder which gives access to the new multi-architecture features. | created by: $ docker buildx create --name mybuilder
docker buildx build --platform linux/amd64,linux/arm64 \
    --push -t pennlinc/modelarray_confixel:${docker_tag} .
    # ^^ first time running this (with `--push`): took 20min...

# ^^ This is fine, but how to split build & push??
    # seems it's still an ongoing issue?
    # https://github.com/docker/buildx/issues/1152


## Try out splitting build & push:
# 1. use `docker buildx build` to build (not to `--push`):
docker buildx build --platform linux/amd64,linux/arm64 \
    --cache-from=pennlinc/modelarray_confixel \
    --rm=false \
    -t pennlinc/modelarray_confixel:${docker_tag} .
    # ^^ took ~385.9s
    #  => ERROR importing cache manifest from pennlinc/modelarray_confixel
        # but did not fail
    # final printed message:
    # WARNING: No output specified for docker-container driver.
        # Build result will only remain in the build cache.
        # To push result image into registry use --push or to load image into docker use --load

# 2. use plain `docker push` to push????
    # I'M NOT SURE..... SEE ABOVE WARNING.....
# docker push pennlinc/modelarray_confixel:${docker_tag}

## Test on local computer:
# e.g., Mac M1:
docker pull pennlinc/modelarray_confixel:unstable
# then run the tests of R + ConFixel
