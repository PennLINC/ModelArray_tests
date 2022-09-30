#!/bin/bash

# This is to call `run_ModelArray.R`.
# Assume this script is in the same folder as the R script.
# The commands here are copied from `setups_on_cubic.sh`

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dir_singularity="/cbica/projects/fixel_db/software/singularity_images"
docker_tag="unstable"  # to change to: "latest"
docker_tag_underscore="unstable"    # a tagged version: change dot to underscore
fn_singularity="${dir_singularity}/modelarray_confixel_${docker_tag_underscore}.sif"   # filename of singularity image with full path
filename_Rscript="run_ModelArray.R"

dir_project="/cbica/projects/fixel_db/dropbox/data_demo/myProject"
dir_mounted_project="/mnt/myProject"
dir_data="${dir_project}/data"   # where the data is downloaded and unzipped
dir_mounted_data="/mnt/data"   # the mounted directory within singularity image
dir_code="${dir_project}/code"
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd $dir_code   # TODO: make sure this is fine
date

# TODO: make sure the `element.subset` has been commented out in the R script!
singularity run --cleanenv -B ${dir_project}:${dir_mounted_project} \
    ${fn_singularity} \
    Rscript ${dir_mounted_project}/code/${filename_Rscript} \
    > printed_message.txt 2>&1   # this is path on cluster, as it's outside the singularity container

date
