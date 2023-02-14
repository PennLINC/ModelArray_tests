#!/bin/bash
# This is to test out `ConVoxel` in Docker image `modelarray_confixel` pulled from docker hub
# convert to nifti files

tag_version="0.1.3"

main_folder="/Users/chenyzh/Desktop/Research/Satterthwaite_Lab/fixel_project/ConFixel/tests/data_voxel_toy"
mounted_dir="/mnt/testdir"

cmd="docker run --rm -it"
cmd+=" -v ${main_folder}:${mounted_dir}"
cmd+=" pennlinc/modelarray_confixel:${tag_version}"
cmd+=" volumestats_write"
cmd+=" --group-mask-file group_mask_FA.nii.gz"
cmd+=" --cohort-file cohort_FA.csv"
cmd+=" --relative-root ${mounted_dir}"  # use the mounted dir
cmd+=" --analysis-name results_lm"
cmd+=" --input-hdf5 FA_wResults.h5"
cmd+=" --output-dir FA_stats"
cmd+=" --output-ext .nii.gz"

echo $cmd
$cmd

# $ docker run --rm -it -v <local/dir>:<mounted/dir> <docker_image> <mounted/dir/as/input>
