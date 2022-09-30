#!/bin/bash

# This is to call `run_ModelArray.R`
# The commands here are copied from `setups_on_cubic.sh`

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dir_singularity="/cbica/projects/fixel_db/software/singularity_images"
docker_tag="unstable"  # to change to: "latest"
docker_tag_underscore="unstable"    # a tagged version: change dot to underscore
fn_singularity="${dir_singularity}/modelarray_confixel_${docker_tag_underscore}.sif"   # filename of singularity image with full path
filename_Rscript="run_ModelArray.R"

dir_data="/cbica/projects/fixel_db/dropbox/data_demo"   # where the data is downloaded and unzipped
dir_mounted_data="/mnt/mydata"   # the mounted directory within singularity image
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd $dir_data
date

# run in `$dir_data`:
# TODO: make sure the `element.subset` has been commented out in the R script!
singularity run --cleanenv -B ${dir_data}:${dir_mounted_data} \
    ${fn_singularity} \
    Rscript ./${filename_Rscript} \
    > printed_message.txt 2>&1

date
