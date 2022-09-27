#!/bin/bash

# This is run on CUBIC, fixel_db project

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dir_singularity="/cbica/projects/fixel_db/software/singularity_images"
docker_tag="unstable"  # to change to: "latest"
docker_tag_underscore="unstable"    # a tagged version: change dot to underscore
fn_singularity="${dir_singularity}/modelarray_confixel_${docker_tag_underscore}.sif"   # filename of singularity image with full path

dir_data="/cbica/projects/fixel_db/dropbox/data_demo"   # where the data is downloaded and unzipped
dir_mounted_data="/mnt/mydata"   # the mounted directory within singularity image
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd ${dir_singularity}
singularity pull --force \
    docker://pennlinc/modelarray_confixel:${docker_tag}
    # ^^ --force:   # if exist, overwrite it
    # if most of layers already exist, quick; if not, will take some time

# test:
singularity run --cleanenv \
    modelarray_confixel_${docker_tag_underscore}.sif \
    R

# ConFixel: mif -> hdf5:
cd ${dir_data}   # `dir_data` cannot start with `~`; otherwise cannot `cd`
singularity run --cleanenv -B ${dir_data}:${dir_mounted_data} \
    ${fn_singularity} \
    confixel \
    --index-file FDC/index.mif \
    --directions-file FDC/directions.mif \
    --cohort-file cohort_FDC_n100.csv \
    --relative-root ${dir_mounted_data} \
    --output-hdf5 demo_FDC_n100.h5

# TODO: test ModelArray part.......