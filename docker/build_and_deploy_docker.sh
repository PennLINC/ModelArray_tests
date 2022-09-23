#!/bin/bash

# This is to figure out the command for building and deploying docker image of ModelArray (and ConFixel)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++
docker_tag="latest"

folder_data_demo="/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/data/data_demo"
mounted_dir="/mnt/testdir"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++

## Build:
# !! command below must be run in folder `ModelArray`:
docker build -t pennlinc/modelarray_confixel:${docker_tag} .
# ^^ this step will take ~2min to rerun (because COPY step in the Dockerfile will be run every time,
    # so does the steps following it, e.g., install ModelArray)

## Tests:
# test ModelArray:
docker run --rm -it pennlinc/modelarray_confixel:${docker_tag} R
    # now you're in an R env with ModelArray installed. Try:
    # > library(ModelArray)
    # > packageVersion("ModelArray")

# test ConFixel:   # ref: babs_tests/prep_toyBIDSApp.sh
    # !!! remember to mount all the folders you want
    # !!! and using `mounted_dir` for `--relative-root`!
docker run --rm -it \
    -v ${folder_data_demo}:${mounted_dir} \
    pennlinc/modelarray_confixel:${docker_tag} \
    confixel \
        --index-file FDC/index.mif \
        --directions-file FDC/directions.mif \
        --cohort-file cohort_FDC_n100.csv \
        --relative-root ${mounted_dir} \
        --output-hdf5 demo_FDC_n100.h5